require 'spec_helper'

describe FindUserFromGithubInfo do
  it 'returns nil when passed an empty hash' do
    create_user(email: 'user@example.com')

    found_user = FindUserFromGithubInfo.call({})

    expect(found_user).to be_nil
  end

  it 'finds user when github id is not present' do
    user = create_user(email: 'user@example.com')

    found_user = FindUserFromGithubInfo.call('email' => 'user@example.com', 'id' => '2342112')

    expect(found_user).to eq user
  end

  describe 'when both email and github id are present' do
    it 'finds user' do
      user = create_user(email: 'user@example.com', github_id: '2342112')

      found_user = FindUserFromGithubInfo.call('email' => 'user@example.com', 'id' => '2342112')

      expect(found_user).to eq user
    end

    it 'finds user even if email is different on github' do
      user = create_user(email: 'user@example.com', github_id: '2342112')

      found_user = FindUserFromGithubInfo.call('email' => 'anotherEmail@example.com', 'id' => '2342112')

      expect(found_user).to eq user
    end
  end
end