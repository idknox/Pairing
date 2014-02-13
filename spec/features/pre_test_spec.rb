require 'spec_helper'

feature "PreTest" do

  let(:instructor) { create_user(first_name: "Github", last_name: "User", github_id: '123', role_bit_mask: 1) }

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

  scenario "instructors can assess the correctness of pretest answers" do
    cohort = Cohort.create(name: "foobar")
    question = PreTestQuestion.create!(text: "Write a Ruby class")

    student1 = create_user first_name: 'Student', last_name: '1', cohort: cohort
    student2 = create_user first_name: 'Student', last_name: '2', cohort: cohort

    pretest1 = PreTest.create!(user: student1, submitted: true)
    pretest2 = PreTest.create!(user: student2, submitted: true)

    answer1 = PreTestAnswer.create!(pre_test: pretest1, question: question, answer_text: "I am correct")
    answer2 = PreTestAnswer.create!(pre_test: pretest2, question: question, answer_text: "I am incorrect")

    sign_in(instructor)

    visit '/cohorts'
    expect(page).to have_link("Pre-Test", :href => cohort_pretest_path(cohort))
    click_link "Pre-Test"

    expect(page).to have_content(question.text)

    click_link "Rate Now", match: :first
    expect(page).to have_content(question.text)
    expect(page).to have_content("I am correct")
    expect(page).to have_content("I am incorrect")
    
    choose "Incorrect", match: :first
    click_on 'Submit'

    expect(answer1.reload.status).to eq('incorrect')
    expect(answer2.reload.status).to eq('correct')
  end

end