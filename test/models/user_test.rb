# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @bob = users(:bob)
    @alice.name = ''
    @bob.name = 'Bob'
  end

  test 'name_or_email' do
    assert_equal 'alice@example.com', @alice.name_or_email
    assert_equal 'Bob', @bob.name_or_email
  end
end
