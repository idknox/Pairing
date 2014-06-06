require 'rails_helper'

describe 'JobOpportunity' do
  describe '.jobs_for_student' do
    it 'returns only job opportunities for a specific user' do
      user = User.new(id: 1)
      user_job_opportunity = JobOpportunity.create!(company_name: "Pivotal", user_id: 1)
      JobOpportunity.create!(company_name: "Pivotal", user_id: 2)

      expect(JobOpportunity.jobs_for_student(user)).to eq [user_job_opportunity]
    end
  end
end