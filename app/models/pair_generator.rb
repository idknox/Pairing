class PairGenerator
  def initialize(students, unpairable = nil)
    @students = students
    @unpairable = unpairable
  end

  def random_pairs
    original_students = @students.to_a.dup

    result = []
    if @unpairable
      while original_students.length > 1
        first = original_students.sample
        second = original_students.sample
        if first != second !@unpairable[first].include?(second) && !@unpairable[second].include?(first)
          result << [original_students.delete(first), original_students.delete(second)]
        end
      end
      result << [original_students.first, nil]
    # else
    #   while original_students.length > 0
    #     result << 2.times.map { original_students.delete(original_students.sample) }
    #   end
    end
    # original_students.map do |student|
    #   original_students.map do |pair|
    #     if student != pair && @unpairable && !@unpairable[student].include?(pair)
    #       result << [student, pair]
    #       original_students.delete(student)
    #       original_students.delete(pair)
    #     end
    #   end
    # end
    # if @students.length % 2 != 0
    #   result << [original_students.first, nil]
    # end
    result
  end
end