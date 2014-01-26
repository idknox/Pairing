require 'test_helper'

describe 'Inviting a student' do
  before do
    @cohort = Cohort.create!(name: 'March gSchool')
  end
  describe 'when the user does not exist' do
    it 'creates a user record' do

      before = User.count
      InviteStudent.call('Bob', 'Smith', 'bob@example.com', @cohort)
      after = User.count

      diff = after - before

      diff.must_equal 1

      user = User.last

      user.first_name.must_equal 'Bob'
      user.last_name.must_equal 'Smith'
      user.email.must_equal 'bob@example.com'
      user.cohort_id.must_equal @cohort.id
    end

    it 'sends an email to the student' do
      ActionMailer::Base.deliveries.clear

      InviteStudent.call('Bob', 'Smith', 'bob@example.com', @cohort)

      created_email = ActionMailer::Base.deliveries.last
      refute created_email.nil?, "Email not found"
      created_email.to.must_equal ['bob@example.com']
      created_email.bcc.must_equal ['kirsten@galvanize.it']
    end
  end

  describe 'when the user already exists by email' do
    before do
      User.create!(email: 'bob@example.com')
    end

    it 'raises an exception' do
      proc { InviteStudent.call('Bob', 'Smith', 'bob@example.com', @cohort) }.must_raise ActiveRecord::RecordInvalid
    end

    it 'does not create a user record' do
      before = User.count
      begin
        InviteStudent.call('Bob', 'Smith', 'bob@example.com', @cohort)
      rescue
      end

      after = User.count

      diff = after - before

      diff.must_equal 0
    end

    it 'does not send an email' do
      ActionMailer::Base.deliveries.clear

      begin
        InviteStudent.call('Bob', 'Smith', 'bob@example.com', @cohort)
      rescue
      end

      ActionMailer::Base.deliveries.size.must_equal 0
    end
  end
end