# frozen_string_literal: true

require_relative 'hexlet_code/version'
require 'active_support/core_ext/string'
# HexletCode - это модуль, который предоставляет возможность генерировать формы.
module HexletCode
  def self.build(tag_name, attributes = {})
    tag_attr = attributes.map { |key, value| "#{key}='#{value}'" }.join(' ')
    if tag_attr.empty?
      "<#{tag_name}>"
    else
      "<#{tag_name} #{tag_attr}/>"
    end
  end

  def self.form_for(user, **kwargs)
    result = []
    form = UserForm.new(user)
    action = kwargs[:url] || kwargs[:action] || '#'
    method = kwargs[:method] || 'post'
    attributes = [
          "action='#{action}'",
          "method='#{method}'",
          ("class='#{kwargs[:class]}'" unless kwargs[:class].nil?)
        ].compact.join(' ')
    result << "<form #{attributes}>"
    result << yield(form) if block_given?
    result << '</form>'
    result.join.strip
  end

  require 'ostruct'
  # UserForm- это класс, который предоставляет возможность создавать поля ввода.
  class UserForm
    def initialize(user)
      @user = user
      @array = []
    end

    def input(input_name, **options)
      value = @user.public_send(input_name) || ''
      type = options.fetch(:as, 'text')
      attr_string = form_attr_string(options)

      person_name = input_name
      @array << "<label for='#{input_name}'>#{person_name.capitalize}</label>"

      if type == :text
        form_textarea(input_name, options, value)
      else
        form_input(input_name, type, value, attr_string)
      end
    end

    def form_attr_string(options)
      additional_attributes = options.reject { |key| key == :as }
      additional_attributes.any?
      additional_attributes.map { |key, value| "#{key}='#{value}'" }.join(' ')
    end

    def form_textarea(input_name, options, value)
      cols = options.fetch(:cols, '10')
      rows = options.fetch(:rows, '20')
      @array << "<textarea name='#{input_name}' cols='#{cols}' rows='#{rows}'>#{value}</textarea>"
    end

    def form_input(name, type, value, attr_string)
      attributes = [
        "name='#{name}'",
        "type='#{type}'",
        "value='#{value}'",
        (attr_string unless attr_string.empty?)
      ].compact.join(' ')

      @array << "<input #{attributes}>"
    end

    def submit(value = 'Save')
      @array << "<input type='submit' value='#{value}'>"
    end
  end
end

def self.form_for(user, action, method, **kwargs)
  result = []
  form = UserForm.new(user)
  input_class = kwargs[:class] if kwargs[:class]
  form_action = kwargs[:url] if kwargs[:url]
  attributes = [
        "action='#{form_action}'",
        "method='#{method}'",
        "class='#{input_class}'",
      ].compact.join(' ')
  result << "<form '#{attributes}'>"
  result << yield(form) if block_given?
  result << '</form>'
  result.join.strip
end
