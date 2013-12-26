require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  describe "Logging in" do
    describe 'when the github username is not present on the user' do
      it 'updates the github username' do
        User.create!(email: 'user@example.com')

        mock_omniauth(info_overrides: {nickname: 'githubUser'})

        get '/auth/github/callback'

        updated_user = User.find_by(email: 'user@example.com')
        updated_user.github_username.must_equal 'githubUser'
      end
    end

    describe 'when the github username is already present on the user' do
      it 'does not update the github username' do
        User.create!(email: 'user@example.com', github_username: 'my_old_name')

        mock_omniauth

        get '/auth/github/callback'

        updated_user = User.find_by(email: 'user@example.com')
        updated_user.github_username.must_equal 'my_old_name'
      end
    end

    describe 'when the github id is not present on the user' do
      it 'updates the github id' do
        User.create!(email: 'user@example.com')

        mock_omniauth(base_overrides: {uid: '12345'})

        get '/auth/github/callback'

        updated_user = User.find_by(email: 'user@example.com')
        updated_user.github_id.must_equal '12345'
      end
    end

    describe 'when the github id is present on the user' do
      it 'does not update the github id' do
        user = User.create!(email: 'user@example.com', github_id: '123')

        mock_omniauth(base_overrides: {uid: '12345'})

        get '/auth/github/callback'

        user.reload.github_id.must_equal '123'
      end
    end
  end
end
