require 'spec_helper'

describe User do
  it 'validates uniqueness of email' do
    User.create!(email: 'sue@example.com')

    user = User.new(email: 'sue@example.com')

    expect(user).to_not be_valid

    user.email = 'bob@example.com'

    expect(user).to be_valid
  end

  it 'has a full name' do
    user = User.new(first_name: 'Bob', last_name: 'Wills')
    expect(user.full_name).to eq 'Bob Wills'
  end
end
