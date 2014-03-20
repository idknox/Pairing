require 'spec_helper'

feature 'PairGenerator' do
  let(:cohort) { Cohort.create!(name: 'g2') }
  let!(:student1) { create_user(first_name: "First", last_name: "Student", github_id: '123', cohort: cohort) }
  let(:instructor) { create_user(first_name: "Github", last_name: "User", github_id: '456', role_bit_mask: User::INSTRUCTOR) }

  scenario 'instructors can generate random pair list' do
    sign_in(instructor)
    click_on 'Instructors'
    click_on 'g2'
    click_on 'Generate Pairs'

    within "tr" do
      expect(page).to have_content student1.full_name
      expect(page).to have_content "Not Paired"
    end
  end
end