require 'spec_helper'

feature "Cohorts" do
  
  scenario "instructor is able to view cohorts" do
    user = create_user(first_name: "Github", last_name: "User", github_id: '123', role_bit_mask: 1)
    sign_in(user)

    cohort = Cohort.create(name: "foobar#{rand(1000)}")
    
    visit '/cohorts'
    
    expect(page).to have_content(cohort.name)
  end
  
  scenario "non-instructors cannot see the cohorts path" do
    Cohort.create(name: "foobar")
    
    visit '/cohorts'
    expect(page.current_path).to eq(root_path)

    user = create_user(first_name: "Github", last_name: "User", github_id: '123')
    sign_in(user)

    visit '/cohorts'
    expect(page.current_path).to eq(root_path)
  end
  
end