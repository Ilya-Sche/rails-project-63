# frozen_string_literal: true

require 'active_support/core_ext/string'
module HexletCode
  # Form- это класс, который предоставляет возможность создавать поля ввода.
  class Form
    attr_reader :form_elements

    def initialize(model)
      @model = model
      @form_elements = []
    end

    def input(attribute, attrs = {})
      value = @model.public_send(attribute)
      tag = attrs.fetch(:as, :input).to_s

      @form_elements << { name: attribute, tag:, type: attrs[:type], value: }.merge(attrs.except(:as))
    end

    def submit(value = 'Save', options = {})
      @form_elements << { tag: 'submit', value: }.merge(options)
    end
  end
end
