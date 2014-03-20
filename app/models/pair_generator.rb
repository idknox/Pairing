class PairGenerator
  def initialize(students)
    @students = students
  end

  def random_pairs
    original_students = @students.to_a.dup
    result = []
    while original_students.length > 0
      result << 2.times.map { original_students.delete(original_students.sample) }
    end
    result
  end

  def rank_based_pairs(rankings)
    students_sorted_by_rank = @students.sort_by do |student|
      rankings.detect { |ranking| ranking.student_id == student.id }.try(:score) || 0
    end.reverse

    result = []
    while students_sorted_by_rank.length > 0
      result << [
        students_sorted_by_rank.delete(students_sorted_by_rank.first),
        students_sorted_by_rank.delete(students_sorted_by_rank.last)
      ]
    end
    result
  end
end