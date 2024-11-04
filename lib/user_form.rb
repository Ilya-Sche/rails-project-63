# frozen_string_literal: true

require_relative 'hexlet_code'
require_relative 'tag'
require 'active_support/core_ext/string'
# UserForm- это класс, который предоставляет возможность создавать поля ввода.
class UserForm
  include Tag
  def initialize(user)
    @user = user
    @form_elements = []
  end
end
