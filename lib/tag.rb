# frozen_string_literal: true

require_relative 'user_form'
require_relative 'hexlet_code'
require 'active_support/core_ext/string'
module Tag

  def input(input_name, options = {})
    value = @user.public_send(input_name) || ''
    attr_string = form_attr_string(options)
    if options[:as] == :text
      build(:textarea, input_name, options, value, attr_string)
    else
      build(:input, input_name, options, value, attr_string)
    end
  end

  def submit(value = 'Save', attr_string = '')
    attributes = [
      "type='submit'",
      "value='#{value}'",
      (attr_string unless attr_string.empty?)
    ].compact.join(' ')

    @form_elements << "<input #{attributes}>"
  end

  private

  def build(tag_name, input_name, options, value, attr_string)

    case tag_name.to_s
    when "label"
      build_label(tag_name, input_name, options)
    when "input"
      build_input(tag_name, input_name, options, value, attr_string)
    when "textarea"
      build_textarea(input_name, options, value, attr_string)
    when "br"
      "</br>"
    end
  end

  def build_label(input_name)
    "<label for='#{input_name}'>#{input_name.capitalize}</label>"
  end
  
  def form_attr_string(options)
    additional_attributes = options.except(:as, :cols, :rows)
    additional_attributes.map { |key, value| "#{key}='#{value}'" }.join(' ')
  end
  
  def build_input(tag_name, input_name, options, value, attr_string)
    attributes = build_input_attributes(input_name, options, value, attr_string)
    label = build_label(input_name)
    result = "<input #{attributes}>"
    @form_elements << label
    @form_elements << result
  end

  def build_textarea(input_name, options, value, attr_string)
    attributes = build_input_attributes(input_name, options, value, attr_string)
    label = build_label(input_name)
    @form_elements << label
    result = "<textarea #{attributes}>#{value}</textarea>"
    @form_elements << result  
  end
  
  def build_input_attributes(input_name, options, value, attr_string)
    [
      "name='#{input_name}'",
      ("cols='#{options[:cols] || '10'}'" if options[:as] == :text),
      ("rows='#{options[:rows] || '20'}'" if options[:as] == :text),
      ("type='text' value='#{value}'" unless options[:as]),
      (attr_string unless attr_string.empty?)
    ].compact.join(' ')
  end
end
  