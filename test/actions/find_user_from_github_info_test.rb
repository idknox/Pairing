require 'test_helper'

describe FindUserFromGithubInfo do
  it 'returns nil when passed an empty hash' do
    User.create!(email: 'user@example.com')

    found_user = FindUserFromGithubInfo.call({})

    found_user.must_be_nil
  end

  it 'finds user when github id is not present' do
    user = User.create!(email: 'user@example.com')

    found_user = FindUserFromGithubInfo.call('email' => 'user@example.com', 'id' => '2342112')

    found_user.must_equal user
  end

  describe 'when both email and github id are present' do
    it 'finds user' do
      user = User.create!(email: 'user@example.com', github_id: '2342112')

      found_user = FindUserFromGithubInfo.call('email' => 'user@example.com', 'id' => '2342112')

      found_user.must_equal user
    end

    it 'finds user even if email is different on github' do
      user = User.create!(email: 'user@example.com', github_id: '2342112')

      found_user = FindUserFromGithubInfo.call('email' => 'anotherEmail@example.com', 'id' => '2342112')

      found_user.must_equal user
    end
  end
end