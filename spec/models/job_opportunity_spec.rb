require 'rails_helper'

describe JobOpportunity do
  describe "#students_applying" do
    it "returns the students that are applying to a job" do
      cohort = create_cohort
      student = create_user(cohort: cohort)
      job = create_job_opportunity
      new_application(user: student, job_opportunity: job).tap do |a|
        a.resume = File.open(File.join(fixture_path, 'resume.pdf'))
      end.save!

      expect(job.applicants ).to match_array([student])
    end
  end
end