require 'spec_helper'

describe FeedbackEntry do

  describe 'validations' do
    let(:feedback_entry) { FeedbackEntry.new(recipient_id: 1, provider_id: 3, comment: "Great Job!") }

    before do
      expect(feedback_entry).to be_valid
    end

    it 'requires a recipient_id' do
      feedback_entry.recipient_id = nil

      expect(feedback_entry).to_not be_valid
    end
    it 'requires a provider_id' do
      feedback_entry.provider_id = nil

      expect(feedback_entry).to_not be_valid
    end
    it 'requires a comment' do
      feedback_entry.comment = nil

      expect(feedback_entry).to_not be_valid
    end
  end

  describe 'getting feedback given to a user' do
    it 'returns only feedback where the user is the recipient' do
      user = User.new(id: 1)
      given_to_user = FeedbackEntry.create!(recipient_id: 1, provider_id: 3, comment: "For you!")
      FeedbackEntry.create!(recipient_id: 999, provider_id: 3, comment: "Not for you.")

      expect(FeedbackEntry.given_to(user)).to eq [given_to_user]
    end
  end

end