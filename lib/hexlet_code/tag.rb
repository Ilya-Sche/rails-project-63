# frozen_string_literal: true

# Tag - это модуль, который предоставляет возможность генерировать тэги.
module Tag
  def self.build(tag, attributes = {})
    attrs = attributes.map { |key, value| "#{key}='#{value}'" }.join(' ')
    content = yield if block_given?
    case tag
    when 'textarea' then textarea_helper(attributes)
    when 'input' then "<#{tag} #{attrs}>"
    when 'label' then "<#{tag} #{attrs}>#{attributes[:for].capitalize}</#{tag}>"
    when 'submit' then "<input type='#{tag}' #{attrs}>"
    else
      "<#{tag} #{attrs}>#{content}</#{tag}>"
    end
  end

  def self.textarea_helper(attributes)
    attributes = {
      name: attributes[:name],
      cols: attributes[:cols] || '10',
      rows: attributes[:rows] || '20',
      value: attributes[:value]
    }
    attrs = attributes.except(:value).map { |key, value| "#{key}='#{value}'" }.join(' ')

    "<textarea #{attrs}>#{attributes[:value]}</textarea>"
  end
end
