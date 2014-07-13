class PairGenerator
  def initialize(students, unpairable = nil)
    @students = students
    @unpairable = unpairable
  end

  def random_pairs
    original_students = @students.to_a.dup

    result = []

    until original_students.length <= 1
      first = original_students.sample
      second = original_students.sample
      if first != second && @unpairable
        if !@unpairable[first].include?(second) || !@unpairable[second].include?(first)
          result << [original_students.delete(first), original_students.delete(second)]
        end
      elsif first != second
        result << [original_students.delete(first), original_students.delete(second)]
      end
    end
    if @students.length % 2 != 0
      result << [original_students.first, nil]
    end
    result
  end
end

