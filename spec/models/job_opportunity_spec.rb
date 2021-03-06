require 'rails_helper'

describe JobOpportunity do
  describe "#students_applying" do
    it "returns the students that are applying to a job" do
      student = create_user
      job = create_job_opportunity
      new_application(user: student, job_opportunity: job).tap do |a|
        a.resume = File.open(File.join(fixture_path, 'resume.pdf'))
      end.save!

      expect(job.applicants ).to match_array([student])
    end
  end

  describe ".opportunities_for" do
    it "finds all the job opportunities that are public or posted by the user" do
      admin = create_user
      student = create_user
      other_student = create_user

      public_job = create_job_opportunity(poster: admin, visibility: "Public")
      private_job = create_job_opportunity(poster: student, visibility: "Private")

      expect(JobOpportunity.opportunities_for(student)).to eq([public_job, private_job])
      expect(JobOpportunity.opportunities_for(other_student)).to eq([public_job])
    end
  end
end
