require 'spec_helper'

describe UserSession do
  let (:rails_session) { Hash.new }
  let (:user_session) { UserSession.new(rails_session) }

  describe "signing in" do
    before do
      expect(user_session).to_not be_signed_in
    end
    it 'knows if a user is signed in from the session' do
      rails_session['user_id'] = 1
      expect(user_session).to be_signed_in
    end

    it 'knows the user is signed in after signing in the user' do
      user = User.new(id: 123)

      user_session.sign_in(user)
      expect(user_session).to be_signed_in
    end
  end

  it 'allows a user to sign out' do
    user = User.new(id: 123)

    user_session.sign_in(user)
    user_session.sign_out

    expect(user_session).to_not be_signed_in
  end

  it 'can get the logged in user' do
    user = create_user(first_name: "Bob", last_name: "Smith", email: "bob@example.com", cohort_id: create_cohort)

    user_session.sign_in(user)

    expect(user_session.current_user).to eq user
  end
end
