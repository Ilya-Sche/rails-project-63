require 'active_support/core_ext/string'
module HexletCode
  # FormRender - это модуль, который 12ы html строки.
  class FormRender
    def initialize(form_elements, form_attributes = {})
      @form_elements = form_elements
      @form_attributes = form_attributes
    end

    def render_elements
      Tag.build('form', @form_attributes) do
        @form_elements.map do |element|
          render_element(element)
        end.join
      end
    end

    def render_element(element)
      case element[:tag]
      when 'input'
        render_input(element)
      when 'text'
        render_textarea(element)
      when 'submit'
        render_submit(element)
      end
    end

    private

    def render_input(element)
      label = Tag.build('label', for: element[:name]) { element[:name].capitalize }
      input_attributes = element.except(:tag)
      input_attributes[:type] = element[:type] || 'text'

      input = Tag.build('input', input_attributes)
      "#{label}#{input}"
    end

    def render_textarea(element)
      label = Tag.build('label', for: element[:name]) { element[:name].capitalize }
      textarea_attributes = element.except(:tag, :type, :value)
      textarea_attributes = textarea_defaults(textarea_attributes)

      textarea = Tag.build('textarea', textarea_attributes) { element[:value] }
      "#{label}#{textarea}"
    end

    def textarea_defaults(textarea_attributes)
      textarea_attributes[:cols] ||= 10
      textarea_attributes[:rows] ||= 20
      {
        name: textarea_attributes[:name],
        cols: textarea_attributes[:cols],
        rows: textarea_attributes[:rows]
      }.merge(textarea_attributes)
    end

    def render_submit(element)
      Tag.build('input', type: 'submit', value: element[:value])
    end
  end
end
