# frozen_string_literal: true

require 'active_support/core_ext/string'

# HexletCode - это модуль, который предоставляет возможность генерировать формы.
module HexletCode
  autoload :UserForm, File.expand_path('hexlet_code/user_form.rb', __dir__)
  autoload :Tag, File.expand_path('hexlet_code/tag.rb', __dir__)
  def self.form_for(user, **kwargs)
    form_builder = UserForm.new(user)

    attributes = kwargs

    if kwargs[:url]
      url = kwargs.delete(:url)
      attributes = { action: url }.merge!(kwargs)
    end

    attributes = { action: '#', method: 'post' } if kwargs.empty?

    Tag.build('form', attributes) do
      yield(form_builder) if block_given?
    end
  end
end
