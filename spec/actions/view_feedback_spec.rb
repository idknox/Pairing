require 'spec_helper'

describe ViewFeedback do
  it 'returns a feedback item marked as viewed for the user' do
    recipient = create_user
    provider = create_user

    entry_to_view = create_feedback_entry(recipient: recipient, provider: provider, viewed: false)

    feedback_item = ViewFeedback.new(recipient, entry_to_view.id).run!

    expect(feedback_item.viewed?).to eq true
  end

  it 'returns a feedback item marked as viewed for the user if the user is an instructor' do
    recipient = create_instructor_user
    provider = create_user

    entry_to_view = create_feedback_entry(recipient: recipient, provider: provider, viewed: false)

    feedback_item = ViewFeedback.new(recipient, entry_to_view.id).run!

    expect(feedback_item.viewed?).to eq true
  end

  it 'raises ActiveRecord::RecordNotFound if the feedback item is not associated with the user' do
    recipient = create_user
    provider = create_user

    entry_to_view = create_feedback_entry(recipient: recipient, provider: provider, viewed: false)

    expect{ViewFeedback.new(provider, entry_to_view.id).run!}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'returns a feedback item for another user if the passed in user is an instructor and does not mark it as viewed' do
    recipient = create_user
    provider = create_user
    instructor = create_instructor_user

    entry_to_view = create_feedback_entry(recipient: recipient, provider: provider, viewed: false)

    feedback_item = ViewFeedback.new(instructor, entry_to_view.id).run!

    expect(feedback_item.viewed?).to eq false
  end
end