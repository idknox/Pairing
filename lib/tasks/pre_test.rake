namespace :pre_test do
  task create_questions: :environment do
    questions = [
      %Q{Write a class named "Bike"},
      %Q{Write a module named "Shed"},
      %Q{Write a comment},
      %Q{Write a multiline comment (w/ begin / end)},
      %Q{Write a local variable named "sum" that holds the value of 1 + 2},
      %Q{Write a class named "User" inside a module named "Authentication"},
      %Q{Write a class named "Watch" that includes a module named "Wearable"},
      %Q{Write a class named "Garden" with an initializer that takes an argument called "plots"},
      %Q{Write a method named "walk" (that takes no arguments)},
      %Q{Write a string with the value "hello"},
      %Q{Write a symbol named "book"},
      %Q{Write a method named "walk" which takes an argument called "speed" and an optional argument "direction" that defaults to "north"},
      %Q{Write a local variable named "awesome" with the value "true"},
      %Q{Write an instance variable named "wheels" with the value "4"},
      %Q{Write an empty array},
      %Q{Write a while loop that ends when a variable named "name" is equal to "Mike" that prints the variable name to the screen},
      %Q{Write an instance variable named "third" who’s value is the 2nd element of an array named "tires"},
      %Q{Write an array with the following values: "a", "b", "c", "d"},
      %Q{Write an empty hash},
      %Q{Write a hash with the following keys / values:  "name" is "batman", "real_name" is "bruce wayne"},
      %Q{Write a local variable named "fights_crime" whose value is true},
      %Q{Write the value of the "name" key of a hash called "superheroes"},
      %Q{Write a constant named "foo" (students should use proper capitalization)},
      %Q{Write a conditional statement that checks if "a" is equal to "b"},
      %Q{Write a case statement to check a local variable named "status" with checks for: "active", "pending"},
      %Q{Write a string with an interpolated value ("holding spots in a string")},
      %Q{Write a string (with any value) and call the "upcase" method on that string},
      %Q{Write iterate over a variable named "pets", and yield a variable named "pet" to the block},
      %Q{Write call a method named foo and pass it a block},
      %Q{Write an empty proc},
      %Q{Write a proc that takes two arguments, "x" and "y"},
      %Q{Write a lambda that takes two arguments "a" and "b"},
      %Q{Write a stabby lambda that takes two arguments "x" and "y"},
      %Q{Write a regular expression that looks for the word cat anywhere},
    ]

    questions.each do |question|
      PreTestQuestion.create!(text: question)
    end
  end
end