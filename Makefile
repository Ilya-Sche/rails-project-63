install:
	bundle install
lint:
	bundle exec rubocop
test:
	ruby test/hexlet_code_test.rb
.PHONY: test
