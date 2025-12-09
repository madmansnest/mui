# frozen_string_literal: true

require "test_helper"

class TestToken < Minitest::Test
  def test_initialization
    token = Mui::Syntax::Token.new(
      type: :keyword,
      start_col: 0,
      end_col: 2,
      text: "def"
    )

    assert_equal :keyword, token.type
    assert_equal 0, token.start_col
    assert_equal 2, token.end_col
    assert_equal "def", token.text
  end

  def test_length
    token = Mui::Syntax::Token.new(
      type: :string,
      start_col: 5,
      end_col: 16,
      text: "hello world"
    )

    assert_equal 11, token.length
  end

  def test_equality
    token1 = Mui::Syntax::Token.new(
      type: :keyword,
      start_col: 0,
      end_col: 2,
      text: "def"
    )
    token2 = Mui::Syntax::Token.new(
      type: :keyword,
      start_col: 0,
      end_col: 2,
      text: "def"
    )

    assert_equal token1, token2
  end

  def test_inequality_different_type
    token1 = Mui::Syntax::Token.new(type: :keyword, start_col: 0, end_col: 2, text: "def")
    token2 = Mui::Syntax::Token.new(type: :identifier, start_col: 0, end_col: 2, text: "def")

    refute_equal token1, token2
  end

  def test_inequality_different_position
    token1 = Mui::Syntax::Token.new(type: :keyword, start_col: 0, end_col: 2, text: "def")
    token2 = Mui::Syntax::Token.new(type: :keyword, start_col: 4, end_col: 6, text: "def")

    refute_equal token1, token2
  end

  def test_inequality_different_text
    token1 = Mui::Syntax::Token.new(type: :keyword, start_col: 0, end_col: 2, text: "def")
    token2 = Mui::Syntax::Token.new(type: :keyword, start_col: 0, end_col: 2, text: "end")

    refute_equal token1, token2
  end

  def test_not_equal_to_non_token
    token = Mui::Syntax::Token.new(type: :keyword, start_col: 0, end_col: 2, text: "def")

    refute_equal token, "def"
    refute_equal token, nil
    refute_equal token, 123
  end
end
