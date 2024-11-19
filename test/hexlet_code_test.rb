# frozen_string_literal: true

require 'minitest/autorun'
autoload :HexletCode, File.expand_path('../lib/hexlet_code', __dir__)
require_relative 'test_helper'

# HexletCodeTest - это модуль, который предоставляет протестировать работоспособность кода.
class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def test_form_for_without_attributes
    user = User.new(name: 'rob', job: 'developer')
    result = HexletCode.form_for(user)
    expected_result = load_fixtures('form_for_without_attributes.html')
    assert_equal expected_result, result
  end

  def test_form_for_with_attributes
    user = User.new(name: 'rob', job: 'developer')
    result = HexletCode.form_for(user, action: '#', method: 'post')
    expected_result = load_fixtures('form_for_with_attributes.html')
    assert_equal expected_result, result
  end

  def test_form_for_with_block_content
    user = User.new(name: 'rob', job: 'developer')
    result = HexletCode.form_for(user, url: '/users', method: 'post', class: 'hexlet-form')
    expected_result = load_fixtures('form_for_with_block_content.html')
    assert_equal expected_result, result
  end

  def test_form_for_input_name_job_as_text
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
    result = HexletCode.form_for(user) do |f|
      f.input :name
      f.input :job, as: :text
    end
    expected_result = load_fixtures('form_for_input_name_job_as_text.html')
    assert_equal expected_result, result
  end

  def test_form_for_input_name_additional_attribute
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
    result = HexletCode.form_for(user, url: '#') do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end
    expected_result = load_fixtures('form_for_input_name_additional_attribute.html')
    assert_equal expected_result, result
  end

  def test_change_cols_and_rows
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
    result = HexletCode.form_for(user, url: '#') do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end
    expected_result = load_fixtures('change_cols_and_rows.html')
    assert_equal expected_result, result
  end

  def test_submit_button
    user = User.new job: 'hexlet'
    result = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
      f.submit
    end
    expected_result = load_fixtures('submit_button.html')
    assert_equal expected_result, result
  end

  def test_submit_button_change
    user = User.new job: 'hexlet'
    result = HexletCode.form_for user, url: '#' do |f|
      f.input :name
      f.input :job
      f.submit 'Wow'
    end
    expected_result = load_fixtures('submit_button_change.html')
    assert_equal expected_result, result
  end
end
