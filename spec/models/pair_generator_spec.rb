require 'spec_helper'

describe PairGenerator do

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

  describe '#rank_based_pairs' do
    let(:rankings) {
      [
        Assessments::Ranking.new(student_id: 1, score: 6),
        Assessments::Ranking.new(student_id: 2, score: 5),
        Assessments::Ranking.new(student_id: 3, score: 4),
        Assessments::Ranking.new(student_id: 4, score: 3),
        Assessments::Ranking.new(student_id: 5, score: 2),
        Assessments::Ranking.new(student_id: 6, score: 1),
      ]
    }

    it "connects highest ranked student to lowest ranked student, and connects pairs inwards from there" do
      pair_generation = PairGenerator.new(students)

      result = pair_generation.rank_based_pairs(rankings)

      expect(result.length).to eq(3)
      expect(result.first).to eq([students[0], students[5]])
      expect(result.second).to eq([students[1], students[4]])
      expect(result.third).to eq([students[2], students[3]])
    end
  end

  describe "#random_pairs" do
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