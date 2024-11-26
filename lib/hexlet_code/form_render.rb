# frozen_string_literal: true

require 'active_support/core_ext/string'
module HexletCode
  # FormRender - это модуль, который предоставляет возможность собирать html строки.
  class FormRender
    def initialize(form_elements)
      @form_elements = form_elements
    end

    def render
      @form_elements.map do |element|
        case element[:tag]
        when 'input'
          render_input(element)
        when 'textarea'
          render_textarea(element)
        when 'submit'
          render_submit(element)
        end
      end.join
    end

    private

    def render_input(element)
      label = Tag.build('label', for: element[:name]) { element[:name].capitalize }

      input_attributes = element.reject { |key| key == :tag }
      input = Tag.build('input', input_attributes)

      "#{label}#{input}"
    end

    def render_textarea(element)
      label = Tag.build('label', for: element[:name]) { element[:name].capitalize }
      textarea_attributes = element.reject { |key| %i[tag value].include?(key) }
      textarea = Tag.build('textarea', textarea_attributes) { element[:value] }
      "#{label}#{textarea}"
    end

    def render_submit(element)
      Tag.build('input', type: 'submit', value: element[:value])
    end
  end
end
