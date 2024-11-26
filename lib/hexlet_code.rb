# frozen_string_literal: true

require 'active_support/core_ext/string'

# HexletCode - это модуль, который предоставляет возможность генерировать формы.
module HexletCode
  autoload :Form, File.expand_path('hexlet_code/form.rb', __dir__)
  autoload :Tag, File.expand_path('hexlet_code/tag.rb', __dir__)
  autoload :FormRender, File.expand_path('hexlet_code/form_render.rb', __dir__)

  def self.form_for(model, form_attrs = {})
    form_builder = Form.new(model)
    attributes = form_attrs

    attributes = { action: attributes.fetch(:url, '#'), method: 'post' }.merge(attributes.except(:url)) if form_attrs
    attributes = { action: '#', method: 'post' } if form_attrs.empty?

    form_elements = []
    form_elements = yield(form_builder) if block_given?

    Tag.build('form', attributes) do
      FormRender.new(form_elements).render
    end
  end
end
