require 'spec_helper'

describe FeedbackEntryIndexPresenter do
  it "allows instructors to view other people's feedback" do
    user = new_user
    presenter = FeedbackEntryIndexPresenter.new(user)

    expect(presenter.can_view_other_feedback?).to eq false

    user.add_role(User::INSTRUCTOR)
    expect(presenter.can_view_other_feedback?).to eq true
  end

  it "can get a list of feedback entries for the user in descending created_at order" do
    user = create_user
    provider = create_user

    yesterdays_feedback = create_feedback_entry(recipient: user, provider: provider, created_at: 1.day.ago)
    todays_feedback = create_feedback_entry(recipient: user, provider: provider, created_at: Date.today)
    create_feedback_entry(recipient: create_user, provider: provider, created_at: Date.today)

    presenter = FeedbackEntryIndexPresenter.new(user)

    expect(presenter.my_feedback_entries).to eq [todays_feedback, yesterdays_feedback]
  end

  describe 'showing a list of feedback entries for a student' do
    let(:recipient) { create_user }
    let(:provider) { create_user }

    it 'returns a list of entries for the passed in user id' do
      instructor = create_instructor_user
      feedback = create_feedback_entry(recipient: recipient, provider: provider)

      presenter = FeedbackEntryIndexPresenter.new(instructor)
      expect(presenter.feedback_entries_for_another_user(recipient.id)).to eq [feedback]
    end
    it 'returns no entries if the id is nil' do
      instructor = create_instructor_user
      create_feedback_entry(recipient: recipient, provider: provider)

      presenter = FeedbackEntryIndexPresenter.new(instructor)
      expect(presenter.feedback_entries_for_another_user(nil)).to eq []
    end

    it 'returns no entries if the current user is not an instructor' do
      user = create_user
      create_feedback_entry(recipient: recipient, provider: provider)

      presenter = FeedbackEntryIndexPresenter.new(user)
      expect(presenter.feedback_entries_for_another_user(recipient.id)).to eq []
    end
  end
end