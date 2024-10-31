# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/hexlet_code'
require 'ostruct'
# HexletCodeTest - это модуль, который предоставляет протестировать работоспособность кода.
class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)
  def test_form_for_without_attributes
    user = User.new(name: 'rob', job: 'developer')
    result = HexletCode.form_for(user)
    assert_equal "<form action='#' method='post'></form>", result
  end

  def test_form_for_with_attributes
    user = User.new(name: 'rob', job: 'developer')
    result = HexletCode.form_for(user, action: '#', method: 'post')
    assert_equal "<form action='#' method='post'></form>", result
  end

  def test_form_for_with_block_content
    user = User.new(name: 'rob', job: 'developer')
    result = HexletCode.form_for(user, url: '/users', method: 'post', class: 'hexlet-form')
    assert_equal "<form action='/users' method='post' class='hexlet-form'></form>", result
  end

  def test_form_for_input_name_job_as_text
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
    result = HexletCode.form_for(user) do |f|
      f.input :name
      f.input :job, as: :text
    end
    assert_equal "<form action='#' method='post'><label for='name'>Name</label>" \
                 "<input name='name' type='text' value='rob'>" \
                 "<label for='job'>Job</label><textarea name='job' cols='10' rows='20'>hexlet</textarea></form>", result
  end

  def test_form_for_input_name_additional_attribute
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
    result = HexletCode.form_for(user, url: '#') do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end
    assert_equal "<form action='#' method='post'><label for='name'>Name</label>" \
                 "<input name='name' type='text' value='rob' class='user-input'>" \
                 "<label for='job'>Job</label><input name='job' type='text' value='hexlet'></form>", result
  end

  def test_change_cols_and_rows
    user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
    result = HexletCode.form_for(user, url: '#') do |f|
      f.input :job, as: :text, rows: 50, cols: 50
    end
    assert_equal "<form action='#' method='post'><label for='job'>Job</label>" \
                 "<textarea name='job' cols='50' rows='50'>hexlet</textarea></form>", result
  end

  def test_submit_button
    user = User.new job: 'hexlet'
    result = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
      f.submit
    end
    assert_equal "<form action='#' method='post'><label for='name'>Name</label>" \
                 "<input name='name' type='text' value=''><label for='job'>Job</label>" \
                 "<input name='job' type='text' value='hexlet'><input type='submit' value='Save'></form>", result
  end

  def test_submit_button_change
    user = User.new job: 'hexlet'
    result = HexletCode.form_for user, url: '#' do |f|
      f.input :name
      f.input :job
      f.submit 'Wow'
    end
    assert_equal "<form action='#' method='post'><label for='name'>Name</label>" \
                 "<input name='name' type='text' value=''><label for='job'>Job</label>" \
                 "<input name='job' type='text' value='hexlet'><input type='submit' value='Wow'></form>", result
  end
end
