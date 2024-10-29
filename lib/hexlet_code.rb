# frozen_string_literal: true

require_relative 'hexlet_code/version'
require 'active_support/core_ext/string'
# HexletCode - это модуль, который предоставляет...
module HexletCode
  def self.build(tag_name, attributes = {})
    tag_attr = attributes.map { |key, value| "#{key}='#{value}'" }.join(' ')
    if tag_attr.empty?
      "<#{tag_name}>"
    else
      "<#{tag_name} #{tag_attr}/>"
    end
  end

  def self.form_for(user, action: '#', method: 'post', url: nil)
    result = []
    form = UserForm.new(user)
    form_action = url || action
    result << "<form action='#{form_action}' method='#{method}'>"
    result << yield(form) if block_given?
    result << '</form>'
    result.join(' ')
  end

  require 'ostruct'
  # UserForm- это класс, который предоставляет...
  class UserForm
    def initialize(user)
      @user = user
      @array = []
    end
  
    def input(name, **options)
      value = @user.public_send(name) || ''
      type = options.fetch(:as, 'text')
      additional_attributes = options.reject { |key| key == :as }

      if additional_attributes.any?
        attr_string = additional_attributes.map { |key, attr_value| "#{key}='#{attr_value}'" }.join(' ')
        @array << attr_string if attr_string&.empty?
      end
    
      if type == :text
        cols = options.fetch(:cols, '10')
        rows = options.fetch(:rows, '20')
        @array << "<textarea name='#{name}' cols='#{cols}' rows='#{rows}'>#{attr_value}</textarea>"
      else
        attributes = [
          "name='#{name}'",
          "type='#{type}'",
          "attr_value='#{attr_value}'",
          (attr_string unless attr_string.nil?)
        ].compact.join(' ')

        @array << "<input #{attributes}>"
      end
    end
  end
end
