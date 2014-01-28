require "spec_helper"

describe Cohort do

  it 'requires a name' do
    cohort = Cohort.new
    expect(cohort).to_not be_valid

    cohort.name = "March gSchool"
    expect(cohort).to be_valid
  end

end