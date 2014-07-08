require 'rails_helper'

describe User do
  it 'validates uniqueness of email' do
    create_user(email: 'sue@example.com')

    user = new_user(email: 'sue@example.com')

    expect(user).to_not be_valid

    user.email = 'bob@example.com'

    expect(user).to be_valid
  end

  it 'requires an email' do
    user = new_user
    expect(user).to be_valid

    user.email = nil
    expect(user).to_not be_valid
  end

  it 'has a full name' do
    user = User.new(first_name: 'Bob', last_name: 'Wills')
    expect(user.full_name).to eq 'Bob Wills'
  end

  it 'can determine if the user is an instructor' do
    user = new_user

    expect(user.is?(User::INSTRUCTOR)).to eq false

    user.add_role(User::INSTRUCTOR)
    expect(user.is?(User::INSTRUCTOR)).to eq true
  end

  describe "#completed_applications" do
    it "gives a list of all the applications that are finished" do
      user = create_user
      pending_application = create_application(user: user, status: Application.statuses[:pending])
      completed_application = create_application(user: user, status: Application.statuses[:applied])

      expect(user.completed_applications.all).to eq([completed_application])
    end
  end

  describe "#pending_applications" do
    it "gives a list of all the applications that are finished" do
      user = create_user
      pending_application = create_application(user: user, status: Application.statuses[:pending])
      completed_application = create_application(user: user, status: Application.statuses[:applied])

      expect(user.pending_applications.all).to eq([pending_application])
    end
  end
end
