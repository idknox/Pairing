require 'spec_helper'

describe 'Inviting a student' do
  before do
    @cohort = Cohort.create!(name: 'March gSchool')
  end
  describe 'when the user does not exist' do
    it 'creates a user record' do
      expect {
        InviteStudent.call('Bob', 'Smith', 'bob@example.com', @cohort)
      }.to change { User.count }.by 1

      user = User.last

      expect(user.first_name).to eq 'Bob'
      expect(user.last_name).to eq 'Smith'
      expect(user.email).to eq 'bob@example.com'
      expect(user.cohort_id).to eq @cohort.id
    end

    it 'sends an email to the student' do
      expect {
        InviteStudent.call('Bob', 'Smith', 'bob@example.com', @cohort)
      }.to change { ActionMailer::Base.deliveries.size }.by 1

      created_email = ActionMailer::Base.deliveries.last
      expect(created_email.to).to eq ['bob@example.com']
      expect(created_email.bcc).to eq ['kirsten@galvanize.it']
    end
  end

  describe 'when the user already exists by email' do
    before do
      create_user(email: 'bob@example.com')
    end

    it 'raises an exception' do
      expect {
        InviteStudent.call('Bob', 'Smith', 'bob@example.com', @cohort)
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'does not create a user record' do
      expect {
        begin
          InviteStudent.call('Bob', 'Smith', 'bob@example.com', @cohort)
        rescue
        end
      }.to_not change { User.count }
    end

    it 'does not send an email' do
      ActionMailer::Base.deliveries.clear

      begin
        InviteStudent.call('Bob', 'Smith', 'bob@example.com', @cohort)
      rescue
      end

      expect(ActionMailer::Base.deliveries.size).to eq 0
    end
  end
end