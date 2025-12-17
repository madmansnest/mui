# frozen_string_literal: true

module Mui
  module Themes
    def self.mui
      scheme = ColorScheme.new("mui")

      # Basic UI colors
      scheme.define :normal, fg: :mui_fg, bg: :mui_bg
      scheme.define :status_line, fg: :mui_fg, bg: :mui_status_bg
      scheme.define :status_line_mode, fg: :mui_bg, bg: :mui_tab_active, bold: true
      scheme.define :search_highlight, fg: :mui_bg, bg: :mui_search
      scheme.define :visual_selection, fg: :mui_fg, bg: :mui_visual
      scheme.define :line_number, fg: :mui_line_number, bg: :mui_bg
      scheme.define :message_error, fg: :mui_error, bg: :mui_bg, bold: true
      scheme.define :message_info, fg: :mui_info, bg: :mui_bg
      scheme.define :separator, fg: :mui_fg, bg: :mui_status_bg
      scheme.define :command_line, fg: :mui_fg, bg: :mui_bg
      scheme.define :tab_bar, fg: :mui_fg, bg: :mui_tab_bg
      scheme.define :tab_bar_active, fg: :mui_bg, bg: :mui_tab_active, bold: true
      scheme.define :completion_popup, fg: :mui_fg, bg: :mui_status_bg
      scheme.define :completion_popup_selected, fg: :mui_bg, bg: :mui_tab_active, bold: true

      # Syntax highlighting following Vim standard highlight groups
      # Comment group
      scheme.define :syntax_comment, fg: :mui_comment

      # Constant group (unified color)
      scheme.define :syntax_string, fg: :mui_constant
      scheme.define :syntax_number, fg: :mui_constant
      scheme.define :syntax_constant, fg: :mui_constant

      # Identifier group (unified color)
      scheme.define :syntax_identifier, fg: :mui_identifier
      scheme.define :syntax_instance_variable, fg: :mui_identifier
      scheme.define :syntax_global_variable, fg: :mui_identifier

      # Statement group
      scheme.define :syntax_keyword, fg: :mui_statement, bold: true
      scheme.define :syntax_operator, fg: :mui_fg

      # PreProc group
      scheme.define :syntax_preprocessor, fg: :mui_preproc

      # Type group
      scheme.define :syntax_type, fg: :mui_type

      # Special group
      scheme.define :syntax_symbol, fg: :mui_special

      # Function calls
      scheme.define :syntax_method_call, fg: :mui_function

      # Diff highlighting
      scheme.define :diff_add, fg: :green
      scheme.define :diff_delete, fg: :mui_error
      scheme.define :diff_hunk, fg: :mui_info
      scheme.define :diff_header, fg: :mui_statement, bold: true

      # LSP diagnostics
      scheme.define :diagnostic_error, fg: :mui_error, underline: true
      scheme.define :diagnostic_warning, fg: :mui_statement, underline: true
      scheme.define :diagnostic_info, fg: :mui_constant, underline: true
      scheme.define :diagnostic_hint, fg: :mui_info, underline: true

      # Floating window
      scheme.define :floating_window, fg: :mui_fg, bg: :mui_status_bg

      scheme
    end

    def self.solarized_dark
      scheme = ColorScheme.new("solarized_dark")

      # Basic UI colors
      scheme.define :normal, fg: :solarized_base0, bg: :solarized_base03
      scheme.define :status_line, fg: :solarized_base1, bg: :solarized_base02
      scheme.define :status_line_mode, fg: :solarized_base03, bg: :solarized_blue, bold: true
      scheme.define :search_highlight, fg: :solarized_base03, bg: :solarized_yellow
      scheme.define :visual_selection, fg: :solarized_base0, bg: :solarized_base02
      scheme.define :line_number, fg: :solarized_base01, bg: :solarized_base03
      scheme.define :message_error, fg: :solarized_red, bg: :solarized_base03, bold: true
      scheme.define :message_info, fg: :solarized_cyan, bg: :solarized_base03
      scheme.define :separator, fg: :solarized_base01, bg: :solarized_base02
      scheme.define :command_line, fg: :solarized_base0, bg: :solarized_base03
      scheme.define :tab_bar, fg: :solarized_base1, bg: :solarized_base02
      scheme.define :tab_bar_active, fg: :solarized_base03, bg: :solarized_blue, bold: true
      scheme.define :completion_popup, fg: :solarized_base1, bg: :solarized_base02
      scheme.define :completion_popup_selected, fg: :solarized_base03, bg: :solarized_blue, bold: true

      # Syntax highlighting (Solarized official)
      scheme.define :syntax_comment, fg: :solarized_base01
      scheme.define :syntax_string, fg: :solarized_cyan
      scheme.define :syntax_number, fg: :solarized_magenta
      scheme.define :syntax_constant, fg: :solarized_cyan
      scheme.define :syntax_identifier, fg: :solarized_blue
      scheme.define :syntax_instance_variable, fg: :solarized_blue
      scheme.define :syntax_global_variable, fg: :solarized_orange
      scheme.define :syntax_keyword, fg: :solarized_green, bold: true
      scheme.define :syntax_operator, fg: :solarized_green
      scheme.define :syntax_preprocessor, fg: :solarized_orange
      scheme.define :syntax_type, fg: :solarized_yellow
      scheme.define :syntax_symbol, fg: :solarized_magenta
      scheme.define :syntax_method_call, fg: :solarized_blue

      # Diff highlighting
      scheme.define :diff_add, fg: :solarized_green
      scheme.define :diff_delete, fg: :solarized_red
      scheme.define :diff_hunk, fg: :solarized_violet
      scheme.define :diff_header, fg: :solarized_yellow, bold: true

      # LSP diagnostics
      scheme.define :diagnostic_error, fg: :solarized_red, underline: true
      scheme.define :diagnostic_warning, fg: :solarized_yellow, underline: true
      scheme.define :diagnostic_info, fg: :solarized_blue, underline: true
      scheme.define :diagnostic_hint, fg: :solarized_cyan, underline: true

      # Floating window
      scheme.define :floating_window, fg: :solarized_base0, bg: :solarized_base02

      scheme
    end

    def self.solarized_light
      scheme = ColorScheme.new("solarized_light")

      # Basic UI colors
      scheme.define :normal, fg: :solarized_base00, bg: :solarized_base3
      scheme.define :status_line, fg: :solarized_base01, bg: :solarized_base2
      scheme.define :status_line_mode, fg: :solarized_base3, bg: :solarized_blue, bold: true
      scheme.define :search_highlight, fg: :solarized_base3, bg: :solarized_yellow
      scheme.define :visual_selection, fg: :solarized_base00, bg: :solarized_base2
      scheme.define :line_number, fg: :solarized_base1, bg: :solarized_base3
      scheme.define :message_error, fg: :solarized_red, bg: :solarized_base3, bold: true
      scheme.define :message_info, fg: :solarized_cyan, bg: :solarized_base3
      scheme.define :separator, fg: :solarized_base1, bg: :solarized_base2
      scheme.define :command_line, fg: :solarized_base00, bg: :solarized_base3
      scheme.define :tab_bar, fg: :solarized_base01, bg: :solarized_base2
      scheme.define :tab_bar_active, fg: :solarized_base3, bg: :solarized_blue, bold: true
      scheme.define :completion_popup, fg: :solarized_base01, bg: :solarized_base2
      scheme.define :completion_popup_selected, fg: :solarized_base3, bg: :solarized_blue, bold: true

      # Syntax highlighting (Solarized official)
      scheme.define :syntax_comment, fg: :solarized_base1
      scheme.define :syntax_string, fg: :solarized_cyan
      scheme.define :syntax_number, fg: :solarized_magenta
      scheme.define :syntax_constant, fg: :solarized_cyan
      scheme.define :syntax_identifier, fg: :solarized_blue
      scheme.define :syntax_instance_variable, fg: :solarized_blue
      scheme.define :syntax_global_variable, fg: :solarized_orange
      scheme.define :syntax_keyword, fg: :solarized_green, bold: true
      scheme.define :syntax_operator, fg: :solarized_green
      scheme.define :syntax_preprocessor, fg: :solarized_orange
      scheme.define :syntax_type, fg: :solarized_yellow
      scheme.define :syntax_symbol, fg: :solarized_magenta
      scheme.define :syntax_method_call, fg: :solarized_blue

      # Diff highlighting
      scheme.define :diff_add, fg: :solarized_green
      scheme.define :diff_delete, fg: :solarized_red
      scheme.define :diff_hunk, fg: :solarized_violet
      scheme.define :diff_header, fg: :solarized_yellow, bold: true

      # LSP diagnostics
      scheme.define :diagnostic_error, fg: :solarized_red, underline: true
      scheme.define :diagnostic_warning, fg: :solarized_yellow, underline: true
      scheme.define :diagnostic_info, fg: :solarized_blue, underline: true
      scheme.define :diagnostic_hint, fg: :solarized_cyan, underline: true

      # Floating window
      scheme.define :floating_window, fg: :solarized_base00, bg: :solarized_base2

      scheme
    end

    def self.monokai
      scheme = ColorScheme.new("monokai")

      # Basic UI colors
      scheme.define :normal, fg: :monokai_fg, bg: :monokai_bg
      scheme.define :status_line, fg: :monokai_fg, bg: :monokai_comment
      scheme.define :status_line_mode, fg: :monokai_bg, bg: :monokai_green, bold: true
      scheme.define :search_highlight, fg: :monokai_bg, bg: :monokai_yellow
      scheme.define :visual_selection, fg: :monokai_fg, bg: :monokai_comment
      scheme.define :line_number, fg: :monokai_comment, bg: :monokai_bg
      scheme.define :message_error, fg: :monokai_pink, bg: :monokai_bg, bold: true
      scheme.define :message_info, fg: :monokai_cyan, bg: :monokai_bg
      scheme.define :separator, fg: :monokai_comment, bg: :monokai_bg
      scheme.define :command_line, fg: :monokai_fg, bg: :monokai_bg
      scheme.define :tab_bar, fg: :monokai_fg, bg: :monokai_comment
      scheme.define :tab_bar_active, fg: :monokai_bg, bg: :monokai_green, bold: true
      scheme.define :completion_popup, fg: :monokai_fg, bg: :monokai_comment
      scheme.define :completion_popup_selected, fg: :monokai_bg, bg: :monokai_green, bold: true

      # Syntax highlighting (Monokai official)
      scheme.define :syntax_comment, fg: :monokai_comment
      scheme.define :syntax_string, fg: :monokai_yellow
      scheme.define :syntax_number, fg: :monokai_purple
      scheme.define :syntax_constant, fg: :monokai_purple
      scheme.define :syntax_identifier, fg: :monokai_fg
      scheme.define :syntax_instance_variable, fg: :monokai_orange
      scheme.define :syntax_global_variable, fg: :monokai_orange
      scheme.define :syntax_keyword, fg: :monokai_pink
      scheme.define :syntax_operator, fg: :monokai_pink
      scheme.define :syntax_preprocessor, fg: :monokai_pink
      scheme.define :syntax_type, fg: :monokai_cyan
      scheme.define :syntax_symbol, fg: :monokai_orange
      scheme.define :syntax_method_call, fg: :monokai_green

      # Diff highlighting
      scheme.define :diff_add, fg: :monokai_green
      scheme.define :diff_delete, fg: :monokai_pink
      scheme.define :diff_hunk, fg: :monokai_purple
      scheme.define :diff_header, fg: :monokai_yellow, bold: true

      # LSP diagnostics
      scheme.define :diagnostic_error, fg: :monokai_pink, underline: true
      scheme.define :diagnostic_warning, fg: :monokai_orange, underline: true
      scheme.define :diagnostic_info, fg: :monokai_cyan, underline: true
      scheme.define :diagnostic_hint, fg: :monokai_green, underline: true

      # Floating window
      scheme.define :floating_window, fg: :monokai_fg, bg: :monokai_comment

      scheme
    end

    def self.nord
      scheme = ColorScheme.new("nord")

      # Basic UI colors
      scheme.define :normal, fg: :nord_snow0, bg: :nord_polar0
      scheme.define :status_line, fg: :nord_snow0, bg: :nord_polar1
      scheme.define :status_line_mode, fg: :nord_polar0, bg: :nord_frost1, bold: true
      scheme.define :search_highlight, fg: :nord_polar0, bg: :nord_aurora_yellow
      scheme.define :visual_selection, fg: :nord_snow0, bg: :nord_polar2
      scheme.define :line_number, fg: :nord_polar3, bg: :nord_polar0
      scheme.define :message_error, fg: :nord_aurora_red, bg: :nord_polar0, bold: true
      scheme.define :message_info, fg: :nord_frost1, bg: :nord_polar0
      scheme.define :separator, fg: :nord_polar3, bg: :nord_polar1
      scheme.define :command_line, fg: :nord_snow0, bg: :nord_polar0
      scheme.define :tab_bar, fg: :nord_snow0, bg: :nord_polar1
      scheme.define :tab_bar_active, fg: :nord_polar0, bg: :nord_frost1, bold: true
      scheme.define :completion_popup, fg: :nord_snow0, bg: :nord_polar2
      scheme.define :completion_popup_selected, fg: :nord_polar0, bg: :nord_frost1, bold: true

      # Syntax highlighting (Nord official)
      scheme.define :syntax_comment, fg: :nord_polar3
      scheme.define :syntax_string, fg: :nord_aurora_green
      scheme.define :syntax_number, fg: :nord_aurora_purple
      scheme.define :syntax_constant, fg: :nord_frost0
      scheme.define :syntax_identifier, fg: :nord_snow0
      scheme.define :syntax_instance_variable, fg: :nord_snow0
      scheme.define :syntax_global_variable, fg: :nord_snow0
      scheme.define :syntax_keyword, fg: :nord_frost2, bold: true
      scheme.define :syntax_operator, fg: :nord_frost2
      scheme.define :syntax_preprocessor, fg: :nord_frost3
      scheme.define :syntax_type, fg: :nord_frost0
      scheme.define :syntax_symbol, fg: :nord_aurora_yellow
      scheme.define :syntax_method_call, fg: :nord_frost1

      # Diff highlighting
      scheme.define :diff_add, fg: :nord_aurora_green
      scheme.define :diff_delete, fg: :nord_aurora_red
      scheme.define :diff_hunk, fg: :nord_frost1
      scheme.define :diff_header, fg: :nord_aurora_yellow, bold: true

      # LSP diagnostics
      scheme.define :diagnostic_error, fg: :nord_aurora_red, underline: true
      scheme.define :diagnostic_warning, fg: :nord_aurora_yellow, underline: true
      scheme.define :diagnostic_info, fg: :nord_frost1, underline: true
      scheme.define :diagnostic_hint, fg: :nord_frost0, underline: true

      # Floating window
      scheme.define :floating_window, fg: :nord_snow0, bg: :nord_polar2

      scheme
    end

    def self.gruvbox_dark
      scheme = ColorScheme.new("gruvbox_dark")

      # Basic UI colors
      scheme.define :normal, fg: :gruvbox_fg, bg: :gruvbox_bg
      scheme.define :status_line, fg: :gruvbox_fg, bg: :gruvbox_gray
      scheme.define :status_line_mode, fg: :gruvbox_bg, bg: :gruvbox_yellow, bold: true
      scheme.define :search_highlight, fg: :gruvbox_bg, bg: :gruvbox_yellow
      scheme.define :visual_selection, fg: :gruvbox_fg, bg: :gruvbox_gray
      scheme.define :line_number, fg: :gruvbox_gray, bg: :gruvbox_bg
      scheme.define :message_error, fg: :gruvbox_red, bg: :gruvbox_bg, bold: true
      scheme.define :message_info, fg: :gruvbox_aqua, bg: :gruvbox_bg
      scheme.define :separator, fg: :gruvbox_gray, bg: :gruvbox_bg
      scheme.define :command_line, fg: :gruvbox_fg, bg: :gruvbox_bg
      scheme.define :tab_bar, fg: :gruvbox_fg, bg: :gruvbox_gray
      scheme.define :tab_bar_active, fg: :gruvbox_bg, bg: :gruvbox_yellow, bold: true
      scheme.define :completion_popup, fg: :gruvbox_fg, bg: :gruvbox_gray
      scheme.define :completion_popup_selected, fg: :gruvbox_bg, bg: :gruvbox_yellow, bold: true

      # Syntax highlighting (Gruvbox official)
      scheme.define :syntax_comment, fg: :gruvbox_gray
      scheme.define :syntax_string, fg: :gruvbox_green
      scheme.define :syntax_number, fg: :gruvbox_purple
      scheme.define :syntax_constant, fg: :gruvbox_purple
      scheme.define :syntax_identifier, fg: :gruvbox_blue
      scheme.define :syntax_instance_variable, fg: :gruvbox_blue
      scheme.define :syntax_global_variable, fg: :gruvbox_blue
      scheme.define :syntax_keyword, fg: :gruvbox_red
      scheme.define :syntax_operator, fg: :gruvbox_fg
      scheme.define :syntax_preprocessor, fg: :gruvbox_aqua
      scheme.define :syntax_type, fg: :gruvbox_yellow
      scheme.define :syntax_symbol, fg: :gruvbox_purple
      scheme.define :syntax_method_call, fg: :gruvbox_aqua

      # Diff highlighting
      scheme.define :diff_add, fg: :gruvbox_green
      scheme.define :diff_delete, fg: :gruvbox_red
      scheme.define :diff_hunk, fg: :gruvbox_aqua
      scheme.define :diff_header, fg: :gruvbox_yellow, bold: true

      # LSP diagnostics
      scheme.define :diagnostic_error, fg: :gruvbox_red, underline: true
      scheme.define :diagnostic_warning, fg: :gruvbox_yellow, underline: true
      scheme.define :diagnostic_info, fg: :gruvbox_blue, underline: true
      scheme.define :diagnostic_hint, fg: :gruvbox_aqua, underline: true

      # Floating window
      scheme.define :floating_window, fg: :gruvbox_fg, bg: :gruvbox_gray

      scheme
    end

    def self.dracula
      scheme = ColorScheme.new("dracula")

      # Basic UI colors
      scheme.define :normal, fg: :dracula_fg, bg: :dracula_bg
      scheme.define :status_line, fg: :dracula_fg, bg: :dracula_selection
      scheme.define :status_line_mode, fg: :dracula_bg, bg: :dracula_purple, bold: true
      scheme.define :search_highlight, fg: :dracula_bg, bg: :dracula_yellow
      scheme.define :visual_selection, fg: :dracula_fg, bg: :dracula_selection
      scheme.define :line_number, fg: :dracula_comment, bg: :dracula_bg
      scheme.define :message_error, fg: :dracula_red, bg: :dracula_bg, bold: true
      scheme.define :message_info, fg: :dracula_cyan, bg: :dracula_bg
      scheme.define :separator, fg: :dracula_comment, bg: :dracula_bg
      scheme.define :command_line, fg: :dracula_fg, bg: :dracula_bg
      scheme.define :tab_bar, fg: :dracula_fg, bg: :dracula_selection
      scheme.define :tab_bar_active, fg: :dracula_bg, bg: :dracula_purple, bold: true
      scheme.define :completion_popup, fg: :dracula_fg, bg: :dracula_selection
      scheme.define :completion_popup_selected, fg: :dracula_bg, bg: :dracula_purple, bold: true

      # Syntax highlighting (Dracula official)
      scheme.define :syntax_comment, fg: :dracula_comment
      scheme.define :syntax_string, fg: :dracula_yellow
      scheme.define :syntax_number, fg: :dracula_purple
      scheme.define :syntax_constant, fg: :dracula_purple
      scheme.define :syntax_identifier, fg: :dracula_fg
      scheme.define :syntax_instance_variable, fg: :dracula_fg
      scheme.define :syntax_global_variable, fg: :dracula_fg
      scheme.define :syntax_keyword, fg: :dracula_pink
      scheme.define :syntax_operator, fg: :dracula_pink
      scheme.define :syntax_preprocessor, fg: :dracula_pink
      scheme.define :syntax_type, fg: :dracula_cyan
      scheme.define :syntax_symbol, fg: :dracula_purple
      scheme.define :syntax_method_call, fg: :dracula_green

      # Diff highlighting
      scheme.define :diff_add, fg: :dracula_green
      scheme.define :diff_delete, fg: :dracula_red
      scheme.define :diff_hunk, fg: :dracula_cyan
      scheme.define :diff_header, fg: :dracula_purple, bold: true

      # LSP diagnostics
      scheme.define :diagnostic_error, fg: :dracula_red, underline: true
      scheme.define :diagnostic_warning, fg: :dracula_orange, underline: true
      scheme.define :diagnostic_info, fg: :dracula_cyan, underline: true
      scheme.define :diagnostic_hint, fg: :dracula_purple, underline: true

      # Floating window
      scheme.define :floating_window, fg: :dracula_fg, bg: :dracula_selection

      scheme
    end

    def self.tokyo_night
      scheme = ColorScheme.new("tokyo_night")

      # Basic UI colors
      scheme.define :normal, fg: :tokyo_fg, bg: :tokyo_bg
      scheme.define :status_line, fg: :tokyo_fg, bg: :tokyo_comment
      scheme.define :status_line_mode, fg: :tokyo_bg, bg: :tokyo_blue, bold: true
      scheme.define :search_highlight, fg: :tokyo_bg, bg: :tokyo_yellow
      scheme.define :visual_selection, fg: :tokyo_fg, bg: :tokyo_comment
      scheme.define :line_number, fg: :tokyo_comment, bg: :tokyo_bg
      scheme.define :message_error, fg: :tokyo_red, bg: :tokyo_bg, bold: true
      scheme.define :message_info, fg: :tokyo_cyan, bg: :tokyo_bg
      scheme.define :separator, fg: :tokyo_comment, bg: :tokyo_bg
      scheme.define :command_line, fg: :tokyo_fg, bg: :tokyo_bg
      scheme.define :tab_bar, fg: :tokyo_fg, bg: :tokyo_comment
      scheme.define :tab_bar_active, fg: :tokyo_bg, bg: :tokyo_blue, bold: true
      scheme.define :completion_popup, fg: :tokyo_fg, bg: :tokyo_comment
      scheme.define :completion_popup_selected, fg: :tokyo_bg, bg: :tokyo_blue, bold: true

      # Syntax highlighting (Tokyo Night official)
      scheme.define :syntax_comment, fg: :tokyo_comment
      scheme.define :syntax_string, fg: :tokyo_green
      scheme.define :syntax_number, fg: :tokyo_orange
      scheme.define :syntax_constant, fg: :tokyo_orange
      scheme.define :syntax_identifier, fg: :tokyo_fg
      scheme.define :syntax_instance_variable, fg: :tokyo_red
      scheme.define :syntax_global_variable, fg: :tokyo_red
      scheme.define :syntax_keyword, fg: :tokyo_purple
      scheme.define :syntax_operator, fg: :tokyo_cyan
      scheme.define :syntax_preprocessor, fg: :tokyo_cyan
      scheme.define :syntax_type, fg: :tokyo_blue
      scheme.define :syntax_symbol, fg: :tokyo_yellow
      scheme.define :syntax_method_call, fg: :tokyo_blue

      # Diff highlighting
      scheme.define :diff_add, fg: :tokyo_green
      scheme.define :diff_delete, fg: :tokyo_red
      scheme.define :diff_hunk, fg: :tokyo_blue
      scheme.define :diff_header, fg: :tokyo_purple, bold: true

      # LSP diagnostics
      scheme.define :diagnostic_error, fg: :tokyo_red, underline: true
      scheme.define :diagnostic_warning, fg: :tokyo_orange, underline: true
      scheme.define :diagnostic_info, fg: :tokyo_cyan, underline: true
      scheme.define :diagnostic_hint, fg: :tokyo_blue, underline: true

      # Floating window
      scheme.define :floating_window, fg: :tokyo_fg, bg: :tokyo_comment

      scheme
    end
  end
end
