# frozen_string_literal: true

require 'active_support/core_ext/string'
module HexletCode
  # Form- это класс, который предоставляет возможность создавать поля ввода.
  class Form
    def initialize(model)
      @model = model
      @form_elements = [].join
    end

    def textarea(attributes)
      attributes = {
        name: attributes[:name],
        cols: attributes[:cols] || '10',
        rows: attributes[:rows] || '20',
        value: attributes[:value]
      }
      @form_elements << Tag.build('textarea', attributes.except(:value)) { attributes[:value] }
    end

    def input(attribute, form_attrs = {})
      label_attributes = { for: attribute }
      @form_elements << Tag.build('label', label_attributes) { label_attributes[:for].capitalize }

      if form_attrs[:as] == :text
        attributes = { name: attribute }.merge(form_attrs.except(:as))
        attributes[:value] = value(attribute)
        textarea(attributes)
      else
        attributes = { name: attribute, type: 'text', value: value(attribute) }.merge(form_attrs)
        @form_elements << Tag.build('input', attributes)
      end
    end

    def submit(value = 'Save', options = {})
      attributes = { type: 'submit', value: }.merge(options)

      @form_elements << Tag.build('input', attributes)
    end

    private

    def value(attribute)
      @model.public_send(attribute) || ''
    end
  end
end
