require "rails_helper"

describe 'Submission' do
  describe "validations" do
    it "requires the github repo name to not have slashes" do
      submission = Submission.create(github_repo_name: "gSchool/students.gschool.it")
      expect(submission.errors[:github_repo_name]).to be_present

      submission.github_repo_name = "students.gschool.it"
      submission.save

      expect(submission.errors[:github_repo_name]).to_not be_present
    end
  end
end
