# frozen_string_literal: true

require "test_helper"

class TestLanguageDetector < Minitest::Test
  # Detection by extension
  def test_detect_ruby_by_extension
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("foo.rb")
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("/path/to/foo.rb")
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("foo.rake")
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("foo.gemspec")
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("config.ru")
  end

  def test_detect_c_by_extension
    assert_equal :c, Mui::Syntax::LanguageDetector.detect("foo.c")
    assert_equal :c, Mui::Syntax::LanguageDetector.detect("/path/to/foo.c")
    assert_equal :c, Mui::Syntax::LanguageDetector.detect("foo.h")
  end

  def test_detect_case_insensitive_extension
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("foo.RB")
    assert_equal :c, Mui::Syntax::LanguageDetector.detect("foo.C")
    assert_equal :c, Mui::Syntax::LanguageDetector.detect("foo.H")
  end

  # Detection by basename
  def test_detect_ruby_by_basename
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("Gemfile")
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("/path/to/Gemfile")
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("Rakefile")
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("Guardfile")
    assert_equal :ruby, Mui::Syntax::LanguageDetector.detect("Vagrantfile")
  end

  # Unknown files
  def test_detect_unknown_extension
    assert_nil Mui::Syntax::LanguageDetector.detect("foo.txt")
    assert_nil Mui::Syntax::LanguageDetector.detect("foo.py")
    assert_nil Mui::Syntax::LanguageDetector.detect("foo.js")
  end

  def test_detect_nil_path
    assert_nil Mui::Syntax::LanguageDetector.detect(nil)
  end

  def test_detect_empty_path
    assert_nil Mui::Syntax::LanguageDetector.detect("")
  end

  # Lexer creation
  def test_lexer_for_ruby
    lexer = Mui::Syntax::LanguageDetector.lexer_for(:ruby)
    assert_instance_of Mui::Syntax::Lexers::RubyLexer, lexer
  end

  def test_lexer_for_c
    lexer = Mui::Syntax::LanguageDetector.lexer_for(:c)
    assert_instance_of Mui::Syntax::Lexers::CLexer, lexer
  end

  def test_lexer_for_unknown
    assert_nil Mui::Syntax::LanguageDetector.lexer_for(:unknown)
    assert_nil Mui::Syntax::LanguageDetector.lexer_for(nil)
  end

  def test_lexer_for_file
    lexer = Mui::Syntax::LanguageDetector.lexer_for_file("foo.rb")
    assert_instance_of Mui::Syntax::Lexers::RubyLexer, lexer
  end

  def test_lexer_for_file_c
    lexer = Mui::Syntax::LanguageDetector.lexer_for_file("main.c")
    assert_instance_of Mui::Syntax::Lexers::CLexer, lexer
  end

  def test_lexer_for_unknown_file
    assert_nil Mui::Syntax::LanguageDetector.lexer_for_file("foo.txt")
    assert_nil Mui::Syntax::LanguageDetector.lexer_for_file(nil)
  end

  # Utility methods
  def test_supported_languages
    languages = Mui::Syntax::LanguageDetector.supported_languages
    assert_includes languages, :ruby
    assert_includes languages, :c
  end

  def test_supported_extensions
    extensions = Mui::Syntax::LanguageDetector.supported_extensions
    assert_includes extensions, ".rb"
    assert_includes extensions, ".c"
    assert_includes extensions, ".h"
  end
end
