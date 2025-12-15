---
title: Jobs
layout: default
nav_order: 6
---

# Asynchronous Jobs
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

Mui's job system allows plugins to run background tasks without blocking the editor. This is essential for:

- Running tests
- Executing linters/formatters
- Making HTTP requests
- Any long-running operation

## Running Async Ruby Code

Use `ctx.run_async` to execute Ruby code in a background thread:

```ruby
command :slow_task do |ctx|
  ctx.set_message("Starting task...")

  ctx.run_async do
    # This runs in a background thread
    sleep 5  # Simulate slow operation
    "Task completed!"
  end
end
```

### With Callback

```ruby
command :fetch_data do |ctx|
  ctx.run_async(on_complete: ->(result) {
    ctx.set_message("Result: #{result}")
  }) do
    # Perform async work
    fetch_from_api
  end
end
```

---

## Running Shell Commands

Use `ctx.run_shell_command` for external processes:

```ruby
command :run_tests do |ctx|
  ctx.set_message("Running tests...")

  ctx.run_shell_command("bundle exec rake test") do |result|
    if result[:success]
      ctx.open_scratch_buffer("[Test Results]", result[:stdout])
      ctx.set_message("Tests passed!")
    else
      ctx.open_scratch_buffer("[Test Errors]", result[:stderr])
      ctx.set_error("Tests failed!")
    end
  end
end
```

### Result Object

The callback receives a hash with:

| Key | Description |
|-----|-------------|
| `:success` | Boolean indicating exit status |
| `:stdout` | Standard output as string |
| `:stderr` | Standard error as string |
| `:exit_status` | Process exit code |

### Example: Linter

```ruby
command :lint do |ctx|
  file = ctx.buffer.file_path

  ctx.run_shell_command("rubocop #{file}") do |result|
    if result[:success]
      ctx.set_message("No lint errors!")
    else
      ctx.open_scratch_buffer("[Lint Results]", result[:stdout])
    end
  end
end
```

---

## Job Management

### Checking Job Status

```ruby
command :status do |ctx|
  if ctx.jobs_running?
    ctx.set_message("Jobs are running...")
  else
    ctx.set_message("No active jobs")
  end
end
```

### Cancelling Jobs

```ruby
command :start_job do |ctx|
  job_id = ctx.run_async do
    # Long running task
    loop do
      sleep 1
    end
  end

  # Store job_id for later cancellation
  @current_job = job_id
end

command :cancel_job do |ctx|
  if @current_job
    ctx.cancel_job(@current_job)
    ctx.set_message("Job cancelled")
  end
end
```

---

## Scratch Buffers

Display job results in a scratch buffer:

```ruby
ctx.open_scratch_buffer(name, content)
```

- Opens in a horizontal split
- Buffer is read-only
- Subsequent calls with same name update existing buffer

### Example: Test Runner

```ruby
command :test do |ctx|
  ctx.run_shell_command("rake test") do |result|
    output = []
    output << "=== Test Results ==="
    output << ""
    output << result[:stdout]

    if result[:stderr].length > 0
      output << ""
      output << "=== Errors ==="
      output << result[:stderr]
    end

    output << ""
    output << "Exit status: #{result[:exit_status]}"

    ctx.open_scratch_buffer("[Test Output]", output.join("\n"))
  end
end
```

---

## Job Events

React to job lifecycle with autocmd:

```ruby
autocmd :JobStarted do |ctx|
  ctx.set_message("Job started")
end

autocmd :JobCompleted do |ctx|
  ctx.set_message("Job completed successfully")
end

autocmd :JobFailed do |ctx|
  ctx.set_error("Job failed!")
end

autocmd :JobCancelled do |ctx|
  ctx.set_message("Job was cancelled")
end
```

---

## Complete Example: Build Plugin

```ruby
class BuildPlugin < Mui::Plugin
  name :build
  version "1.0.0"
  description "Build and test runner"

  def setup
    command :build do |ctx|
      run_build(ctx)
    end

    command :test do |ctx|
      run_tests(ctx)
    end

    command :check do |ctx|
      run_build(ctx)
      run_tests(ctx)
    end

    keymap :normal, "<Leader>b" do |ctx|
      run_build(ctx)
    end

    keymap :normal, "<Leader>t" do |ctx|
      run_tests(ctx)
    end

    autocmd :JobCompleted do |ctx|
      # Could trigger notifications, update status line, etc.
    end
  end

  private

  def run_build(ctx)
    ctx.set_message("Building...")

    ctx.run_shell_command("make build") do |result|
      if result[:success]
        ctx.set_message("Build succeeded!")
      else
        ctx.open_scratch_buffer("[Build Errors]", result[:stderr])
        ctx.set_error("Build failed!")
      end
    end
  end

  def run_tests(ctx)
    ctx.set_message("Running tests...")

    ctx.run_shell_command("make test") do |result|
      ctx.open_scratch_buffer("[Test Results]", result[:stdout])

      if result[:success]
        ctx.set_message("All tests passed!")
      else
        ctx.set_error("Tests failed!")
      end
    end
  end
end
```

---

## Interactive Commands

For commands that require user interaction (like fzf), use `run_interactive_command`:

```ruby
command :find_file do |ctx|
  unless ctx.command_exists?("fzf")
    ctx.set_error("fzf is not installed")
    return
  end

  # This temporarily exits curses mode
  result = ctx.run_interactive_command("find . -type f | fzf")

  if result && !result.empty?
    ctx.editor.execute_command("e #{result.strip}")
  end
end
```

{: .note }
`run_interactive_command` blocks and waits for the command to complete. Use this only for interactive CLI tools that require terminal access.
