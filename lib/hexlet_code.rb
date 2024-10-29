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

  def self.form_for(user, action: "#", method: "post", url: nil)
    result = []
    form = UserForm.new(user)

    if url
      result << "<form action='#{url}' method='#{method}'>"
    else
      result << "<form action='#{action}' method='#{method}'>"
    end

    result << yield(form) if block_given?
    result << "</form>"
    result.join('')
  end
  

  require 'ostruct'
  class UserForm

    def initialize(user)
      @user = user
      @array = []
    end
  
    def input(input_name, **options)
      value = @user.public_send(input_name) || ''    
      type = options.fetch(:as, 'text')
      additional_attributes = options.reject { |key| key == :as }

      if additional_attributes.any?
        attr_string = additional_attributes.map { |key, value| "#{key}='#{value}'" }.join(' ')
        @array << attr_string if attr_string&.empty?
      end
    
      if type == :text
        cols = options.fetch(:cols, '10')
        rows = options.fetch(:rows, '20')
        @array << "<textarea name='#{input_name}' cols='#{cols}' rows='#{rows}'>#{value}</textarea>"
      else
        attributes = [
          "name='#{input_name}'",
          "type='#{type}'",
          "value='#{value}'",
          (attr_string unless attr_string.nil?)
        ].compact.join(' ')

        @array << "<input #{attributes}>"
      end
    end
  end
end

# "<form action='#' method='post'><input name='name' type='text' value='rob'><textarea name='job' cols='20' rows='40'>hexlet</textarea></form>"
# result = HexletCode.form_for(user) do |f|
#   f.input :name
#   f.input :job, as: :text
# end



# def self.form_for(user, method: "#", action: "post")
#   result = []
#   form = UserForm.new(user)
#   result << "<form action='#{action}' method='#{method}'>"
#   result << = yield(form) if block_given?
#   result << = "</form>"
#   result
# end

# def self.form_for(user, attr = {}, &block)
# form = UserForm.new(user)
#   action = attr.delete(:url) || '#'
#   user_attr = attr.map { |key, value| "#{key}='#{value}'" }.join(' ')
#   result = "<form#{user_attr.empty? ? '' : " #{user_attr}"}>"
#   yield(form) if block_given?
#   result << form.to_s
#   result << "</form>"
#   result
# end
# type = options.fetch(:as, 'text')