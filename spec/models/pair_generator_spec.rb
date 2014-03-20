require 'spec_helper'

describe PairGenerator do

  describe "#random_pairs" do

    let(:students) {
      [
        User.new(id: 1),
        User.new(id: 2),
        User.new(id: 3),
        User.new(id: 4),
        User.new(id: 5),
        User.new(id: 6)
      ]
    }

    it "returns an array of arrays of pairs of students" do
      pair_generator = PairGenerator.new(students)
      result = pair_generator.random_pairs

      expect(result.length).to eq(3)
      result.each do |pair|
        expect(students).to include(pair.first)
        expect(students).to include(pair.last)
      end
      expect(result.flatten).to match_array(students)
    end

    it "returns nil for the second student if there's an odd number" do
      students.delete(students.last)

      pair_generator = PairGenerator.new(students)
      result = pair_generator.random_pairs
      expect(result.length).to eq(3)
      expect(result.last.last).to be_nil
    end

    it "doesn't return the same results when called multiple times" do
      pair_generator = PairGenerator.new(students)

      result1 = pair_generator.random_pairs
      result2 = pair_generator.random_pairs

      expect(result1).to_not eq(result2)
    end

  end

end