require 'spec_helper'

feature "Cohorts" do

  let(:instructor) { create_user(first_name: "Github", last_name: "User", github_id: '123', role_bit_mask: 1) }
  let(:student) { create_user(first_name: "Github", last_name: "User", github_id: '123') }

  scenario "instructor is able to view cohorts" do
    sign_in(instructor)

    cohort = Cohort.create(name: "foobar#{rand(1000)}")

    visit '/cohorts'

    expect(page).to have_content(cohort.name)
  end

  scenario "non-instructors cannot see the cohorts path" do
    Cohort.create(name: "foobar")

    visit '/cohorts'
    expect(page.current_path).to eq(root_path)

    sign_in(student)

    visit '/cohorts'
    expect(page.current_path).to eq(root_path)
  end

  scenario "instructors can assess the correctness of answers" do
    cohort = Cohort.create(name: "foobar")
    question = PreTestQuestion.create!(text: "Write a Ruby class")

    student1 = create_user first_name: 'Student', last_name: '1', cohort: cohort
    student2 = create_user first_name: 'Student', last_name: '2', cohort: cohort

    pretest1 = PreTest.create!(user: student1)
    pretest2 = PreTest.create!(user: student2)

    PreTestAnswer.create!(pre_test: pretest1, question: question, answer_text: "I am correct")
    PreTestAnswer.create!(pre_test: pretest2, question: question, answer_text: "I am incorrect")
    
    sign_in(instructor)

    visit '/cohorts'
    expect(page).to have_link("Pre-Test", :href => cohort_pretest_path(cohort))
    click_link "Pre-Test"

    expect(page).to have_content(question.text)

    click_link "Rate Now", match: :first
    expect(page).to have_content(question.text)
    expect(page).to have_content("I am correct")
    expect(page).to have_content("I am incorrect")
  end
end