# frozen_string_literal: true

require 'active_support/core_ext/string'

# HexletCode - это модуль, который предоставляет возможность генерировать формы.
module HexletCode
  autoload :Form, File.expand_path('hexlet_code/form.rb', __dir__)
  autoload :Tag, File.expand_path('hexlet_code/tag.rb', __dir__)
  autoload :FormRender, File.expand_path('hexlet_code/form_render.rb', __dir__)

  def self.form_for(model, form_attrs = {})
    form_builder = Form.new(model)
    form_attributes = { action: form_attrs.fetch(:url, '#'), method: 'post' }.merge(form_attrs.except(:url))

    yield(form_builder) if block_given?
    FormRender.new(form_builder.form_elements, form_attributes).render_elements
  end
end
