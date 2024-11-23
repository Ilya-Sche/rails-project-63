# frozen_string_literal: true

require 'active_support/core_ext/string'

# HexletCode - это модуль, который предоставляет возможность генерировать формы.
module HexletCode
  autoload :Form, File.expand_path('hexlet_code/form.rb', __dir__)
  autoload :Tag, File.expand_path('hexlet_code/tag.rb', __dir__)
  def self.form_for(model, form_attrs = {})
    form_builder = Form.new(model)
    attributes = form_attrs

    if form_attrs[:url]
      attributes = { action: attributes.fetch(:url, '#'), method: 'post' }.merge(attributes.except(:url))
    end
    attributes = { action: '#', method: 'post' } if form_attrs.empty?

    Tag.build('form', attributes) do
      yield(form_builder) if block_given?
    end
  end
end
