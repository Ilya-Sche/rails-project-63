# frozen_string_literal: true

require 'minitest/autorun'
$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))
require '../lib/hexlet_code/hexlet_code'

def load_fixtures(fixture_name)
  File.expand_path("../fixtures/#{fixture_name}", __dir__)
  File.read(fixture_name)
end
