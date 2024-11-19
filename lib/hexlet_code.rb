# frozen_string_literal: true

require 'active_support/core_ext/string'
$LOAD_PATH.unshift(File.expand_path('/lib', __dir__))

# HexletCode - это модуль, который предоставляет возможность генерировать формы.
module HexletCode
  autoload :UserForm, './lib/hexlet_code/user_form'
  autoload :Tag, './lib/hexlet_code/tag'
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
