# frozen_string_literal: true

require 'active_support/core_ext/string'
module HexletCode
  # Form- это класс, который предоставляет возможность создавать поля ввода.
  class Form
    def initialize(model)
      @model = model
      @form_elements = []
    end

    def textarea(attributes)
      @form_elements << {
        tag: 'textarea',
        name: attributes[:name],
        value: attributes[:value],
        cols: 10,
        rows: 20
      }.merge(attributes.except(:value))
    end

    def input(attribute, form_attrs = {})
      @form_elements << add_label(attribute)
      if form_attrs[:as] == :text
        attributes = { name: attribute }.merge(form_attrs.except(:as))
        attributes[:value] = value(attribute)
        textarea(attributes)
      else
        @form_elements << add_input(attribute, form_attrs)
      end
    end

    def submit(value = 'Save', options = {})
      @form_elements << { tag: 'submit', value: }.merge(options)
    end

    private

    def add_input(attribute, form_attrs = {})
      attributes = { name: attribute, type: 'text', value: value(attribute) }.merge(form_attrs)
      {
        tag: 'input',
        name: attribute,
        type: attributes[:type],
        value: value(attribute)
      }.merge(form_attrs)
    end

    def add_label(attribute)
      {
        tag: 'label',
        name: attribute,
        value: attribute.capitalize
      }
    end

    def value(attribute)
      @model.public_send(attribute) || ''
    end
  end
end
