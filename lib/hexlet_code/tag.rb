# frozen_string_literal: true

module HexletCode
  # Tag - это модуль, который предоставляет возможность генерировать тэги.
  module Tag
    SELF_CLOSING_TAGS = %w[input img br hr meta link].freeze

    def self.build(tag, attributes = {})
      attrs = attributes.map { |key, value| "#{key}='#{value}'" }.join(' ')
      content = yield if block_given?
      if SELF_CLOSING_TAGS.include?(tag)
        "<#{tag} #{attrs}>"
      else
        "<#{tag} #{attrs}>#{content}</#{tag}>"
      end
    end
  end
end
