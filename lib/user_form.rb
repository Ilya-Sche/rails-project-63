# frozen_string_literal: true

require_relative 'hexlet_code'
require 'active_support/core_ext/string'
# UserForm- это класс, который предоставляет возможность создавать поля ввода.
class UserForm
  def initialize(user)
    @user = user
    @form_elements = []
  end

  def input(input_name, **options)
    value = @user.public_send(input_name) || ''
    attr_string = form_attr_string(options)

    @form_elements << "<label for='#{input_name}'>#{input_name.capitalize}</label>"

    input_attributes(input_name, options, value, attr_string)
  end

  def form_attr_string(options)
    additional_attributes = options.except(:as, :cols, :rows)
    additional_attributes.map { |key, value| "#{key}='#{value}'" }.join(' ')
  end

  def input_attributes(input_name, options, value, attr_string)
    attributes = build_input_attributes(input_name, options, value, attr_string)

    result = if options[:as] == :text
               "<textarea #{attributes}>#{value}</textarea>"
             else
               "<input #{attributes}>"
             end

    @form_elements << result
  end

  def build_input_attributes(input_name, options, value, attr_string)
    [
      "name='#{input_name}'",
      ("cols='#{options[:cols] || '10'}'" if options[:as]),
      ("rows='#{options[:rows] || '20'}'" if options[:as]),
      ("type='text'" unless options[:as]),
      ("value='#{value}'" unless options[:as]),
      (attr_string unless attr_string.empty?)
    ].compact.join(' ')
  end

  def submit(value = 'Save', attr_string = '')
    attributes = [
      "type='submit'",
      "value='#{value}'",
      (attr_string unless attr_string.empty?)
    ].compact.join(' ')

    @form_elements << "<input #{attributes}>"
  end
end
