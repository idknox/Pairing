require 'test_helper'

describe 'Inviting a student' do
  it 'creates a user record' do
    before = User.count
    InviteStudent.call('Bob', 'Smith', 'bob@example.com')
    after = User.count

    diff = after - before

    assert_equal(diff, 1)

    user = User.last

    user.first_name.must_equal 'Bob'
    user.last_name.must_equal 'Smith'
    user.email.must_equal 'bob@example.com'
  end

  it 'sends an email to the student' do
    ActionMailer::Base.deliveries.clear

    InviteStudent.call('Bob', 'Smith', 'bob@example.com')

    created_email = ActionMailer::Base.deliveries.last
    refute created_email.nil?, "Email not found"
    created_email.to.must_equal ['bob@example.com']
  end
end