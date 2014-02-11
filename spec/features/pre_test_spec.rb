require 'spec_helper'

feature "PreTest" do
  scenario "allows student to take the pre-test" do

    PreTestQuestion.create!(text: %Q{Write a class named "Bike"})
    PreTestQuestion.create!(text: %Q{Write a module named "Shed"})

    user = create_user(first_name: "Github", last_name: "User", github_id: '123')
    sign_in(user)

    visit '/pre-test'
    click_button 'Start the Pre Test'

    fill_in %Q{Write a class named "Bike"}, with: 'class Bike;end'

    click_button 'Next Question'
    click_link 'See all answers'

    expect(page).to have_content(%Q{Write a class named "Bike"})
    expect(page).to have_content('class Bike;end')


    click_on %Q{Write a class named "Bike"}
    fill_in %Q{Write a class named "Bike"}, with: 'class Foo;end'
    click_button 'Next Question'
    click_link 'See all answers'

    expect(page).to have_content(%Q{Write a class named "Bike"})
    expect(page).to have_content('class Foo;end')

    click_button 'Submit'

    expect(page).to have_content('Thanks! All done.')
    expect(page).to have_no_selector('a', text: %Q{Write a class named "Bike"})
    expect(page).to have_no_selector('input[value=Submit]')
  end

end