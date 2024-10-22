# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/hexlet_code'

class HexletCodeTest < Minitest::Test
  def test_form_for_without_attributes
    user = Struct.new(:name, :job, keyword_init: true).new(name: 'rob', job: 'developer')
    result = HexletCode.form_for(user)
    assert_equal '<form></form>', result
  end

  def test_form_for_with_attributes
    user = Struct.new(:name, :job, keyword_init: true).new(name: 'rob', job: 'developer')
    result = HexletCode.form_for(user, action: '#', method: 'post')
    assert_equal "<form action='#' method='post'></form>", result
  end

  def test_form_for_with_block_content
    user = Struct.new(:name, :job, keyword_init: true).new(name: 'rob', job: 'developer')
    result = HexletCode.form_for(user, action: '/users', method: 'post')
    assert_equal "<form action='/users' method='post'></form>", result
  end
end
