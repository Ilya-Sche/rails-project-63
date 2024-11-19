# frozen_string_literal: true

require 'minitest/autorun'

def load_fixtures(fixture_name)
  File.expand_path("../fixtures/#{fixture_name}", __dir__)
  File.read(fixture_name)
end
