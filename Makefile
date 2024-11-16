install:
	bundle install
lint:
	bundle exec rubocop
test:
	cd test && ruby hexlet_code_test.rb
.PHONY: test
