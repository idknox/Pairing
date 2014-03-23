require 'spec_helper'

describe ViewFeedback do

  describe 'when an instructor is viewing feedback' do
    it 'returns a feedback item and does not mark it as viewed' do
      recipient = create_user
      provider = create_user
      instructor = create_instructor_user

      entry_to_view = create_feedback_entry(recipient: recipient, provider: provider, viewed: false)

      feedback_item = ViewFeedback.new(instructor, entry_to_view.id).run!

      expect(feedback_item.viewed?).to eq false
    end
  end

  describe 'when the recipient is viewing feedback' do
    it 'returns a feedback item marked as viewed' do
      recipient = create_user
      provider = create_user

      entry_to_view = create_feedback_entry(recipient: recipient, provider: provider, viewed: false)

      feedback_item = ViewFeedback.new(recipient, entry_to_view.id).run!

      expect(feedback_item.viewed?).to eq true
    end

    it 'returns a feedback item marked if the recipient is an instructor' do
      instructor = create_instructor_user
      provider = create_user

      entry_to_view = create_feedback_entry(recipient: instructor, provider: provider, viewed: false)

      feedback_item = ViewFeedback.new(instructor, entry_to_view.id).run!

      expect(feedback_item.viewed?).to eq true
    end
  end

  describe 'when the provider is viewing feedback' do
    it 'returns a feedback item marked as not viewed' do
      recipient = create_user
      provider = create_user

      entry_to_view = create_feedback_entry(recipient: recipient, provider: provider, viewed: false)

      feedback_item = ViewFeedback.new(provider, entry_to_view.id).run!

      expect(feedback_item.viewed?).to eq false
    end
  end


  it 'raises ActiveRecord::RecordNotFound if the feedback item is not associated to the viewer' do
    recipient = create_user
    provider = create_user

    entry_to_view = create_feedback_entry(recipient: recipient, provider: provider, viewed: false)

    expect{ViewFeedback.new(create_user, entry_to_view.id).run!}.to raise_error(ActiveRecord::RecordNotFound)
  end
end