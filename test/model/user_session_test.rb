require 'test_helper'

describe UserSession do
  let (:rails_session) { Hash.new }
  let (:user_session) { UserSession.new(rails_session) }

  describe "signing in" do
    before do
      user_session.signed_in?.must_equal false
    end
    it 'knows if a user is signed in from the session' do
      rails_session['user_id'] = 1
      user_session.signed_in?.must_equal true
    end

    it 'knows the user is signed in after signing in the user' do
      user = User.new(id: 123)

      user_session.sign_in(user)
      user_session.signed_in?.must_equal true
    end
  end

  it 'allows a user to sign out' do
    user = User.new(id: 123)

    user_session.sign_in(user)
    user_session.sign_out

    user_session.signed_in?.must_equal false
  end
end
