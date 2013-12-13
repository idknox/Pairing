require 'test_helper'

describe User do
  it 'validates uniqueness of email' do
    User.create!(email: 'sue@example.com')

    user = User.new(email: 'sue@example.com')

    user.valid?.must_equal false

    user.email = 'bob@example.com'

    user.valid?.must_equal true
  end
end
