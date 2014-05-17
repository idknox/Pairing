require 'spec_helper'

feature "Clicker", js: :true do

  scenario "Instructor sees how many students are in the class" do
    in_browser(:instructor) do
      visit "/clicker"
      click_on "Boulder"
      click_on "I'm an Instructor"
      expect(page).to have_content("Lesson Overview")
      expect(page).to have_content("0 Students")
    end

    in_browser(:student) do
      visit "/clicker"
      click_on "Boulder"
      click_on "I'm a Student"
      expect(page).to have_content("Welcome, grasshopper!")
    end

    in_browser(:instructor) do
      expect(page).to have_content("1")
    end

    in_browser(:other_student) do
      visit "/clicker"
      click_on "Boulder"
      click_on "I'm a Student"
    end

    in_browser(:instructor) do
      expect(page).to have_content("2")
    end

    in_browser(:other_student) do
      click_on "You lost me"
    end

    in_browser(:instructor) do
      expect(page).to have_css(".student-circle.is-behind")
    end

    in_browser(:student) do
      click_on "I'm caught-up"
    end

    in_browser(:instructor) do
      expect(page).to have_css(".student-circle.is-caught-up")
      click_on "Reset"
      expect(page).to have_no_css(".student-circle.is-behind")
      expect(page).to have_no_css(".student-circle.is-caught-up")
    end
  end

  scenario "Asking questions in denver" do
    in_browser(:denver_instructor) do
      visit "/clicker"
      click_on "Denver"
      click_on "I'm an Instructor"
      expect(page).to have_content("Lesson Overview")
      expect(page).to have_content("0 Students")
    end

    in_browser(:student) do
      visit "/clicker"
      click_on "Denver"
      click_on "I'm a Student"
    end

    in_browser(:denver_instructor) do
      expect(page).to have_content("1 Student")
    end

    in_browser(:boulder_instructor) do
      visit "/clicker"
      click_on "Boulder"
      click_on "I'm an Instructor"

      expect(page).to have_content("Lesson Overview")
      expect(page).to have_content("0 Students")
    end
  end

end