require "test_helper"

describe Cohort do

  it 'requires a name' do
    cohort = Cohort.new
    assert !cohort.valid?, "Cohort valid when it should be invalid"

    cohort.name = "March gSchool"
    assert cohort.valid?
  end

end