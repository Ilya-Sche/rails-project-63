# frozen_string_literal: true

require_relative 'user_form'
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
    attributes = form_for_attributes(kwargs)
    result << "<form #{attributes}>"
    result << yield(form) if block_given?
    result << '</form>'
    result.join.strip
  end

  def self.form_for_attributes(kwargs)
    add_attr = kwargs.except(:url, :action, :method).map { |key, value| "#{key}='#{value}'" }.join(' ')
    action = kwargs[:url] || kwargs[:action] || '#'
    http_method = kwargs[:method] || 'post'
    [
      "action='#{action}'",
      "method='#{http_method}'",
      (add_attr unless add_attr.empty?)
    ].compact.join(' ')
  end
end
