require 'spec_helper'

describe GiveFeedback do
  it 'sends an email to the user when feedback is received' do
    user = User.create!(first_name: 'Mike', last_name: 'Gehard', email: 'mg@gmail.com')

    action = GiveFeedback.new(user, user, "Great job!")

    expect { action.run! }.to change {
      ActionMailer::Base.deliveries.size
    }.by 1
  end
end