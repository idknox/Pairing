require "spec_helper"

describe Cohort do

  it 'requires a name' do
    cohort = new_cohort(name: "")
    expect(cohort).to_not be_valid

    cohort.name = "March gSchool"
    expect(cohort).to be_valid
  end

end
