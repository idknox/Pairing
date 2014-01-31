require 'spec_helper'

describe GiveFeedback do
  it 'sends an email to the user when feedback is received' do
    user = create_user

    action = GiveFeedback.new(user, user, "Great job!")

    expect { action.run! }.to change {
      ActionMailer::Base.deliveries.size
    }.by 1
  end
end