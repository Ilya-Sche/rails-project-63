# frozen_string_literal: true

require_relative 'hexlet_code/version'
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

  def self.form_for(attr = {}, &block)
    user_attr = attr.map { |key, value| "#{key}='#{value}'" }.join(' ')
    result = "<form#{user_attr.empty? ? '' : " #{user_attr}"}>"
    (block_given? && block.call) || ''
    result += yield
    result += '</form>'
    result
  end
end
