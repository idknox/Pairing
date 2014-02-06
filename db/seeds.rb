Cohort.destroy_all
PreTestQuestion.destroy_all

Cohort.create! do |cohort|
  cohort.name = "Cohort 1"
end

PreTestQuestion.create!(text: %Q{Write a class named "Bike"})
PreTestQuestion.create!(text: %Q{Write a module named "Shed"})
