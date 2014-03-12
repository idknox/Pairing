require 'spec_helper'

describe OneOnOneScheduler do
  describe '#generate_schedule' do

    it 'populates the appointments' do
      student = [User.new(first_name: "Student")]
      instructor = [User.new(first_name: "Instructor")]
      scheduler = OneOnOneScheduler.new([student], [instructor])
      scheduler.generate_schedule
      expect(scheduler.appointments.length).to eq(1)
    end

  end
end