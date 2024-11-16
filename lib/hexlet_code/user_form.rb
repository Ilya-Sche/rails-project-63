# frozen_string_literal: true

require 'byebug'
require 'active_support/core_ext/string'
# UserForm- это класс, который предоставляет возможность создавать поля ввода.
class UserForm
  include Tag

  def initialize(user)
    @user = user
    @form_elements = [].join
  end

  def input(attribute, **kwargs)
    label_attributes = { for: attribute }
    @form_elements << Tag.build('label', label_attributes)

    if kwargs[:as] == :text
      attributes = { name: attribute }.merge(kwargs.except(:as))

      attributes.merge!({ value: value(attribute) })
      @form_elements << Tag.build('textarea', attributes)
    else
      attributes = { name: attribute, type: 'text', value: value(attribute) }.merge(kwargs)
      @form_elements << Tag.build('input', attributes)
    end
  end

  def submit(value = 'Save')
    attributes = { value: }

    @form_elements << Tag.build('submit', attributes)
  end

  private

  def value(attribute)
    @user.public_send(attribute) || ''
  end
end
