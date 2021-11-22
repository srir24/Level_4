require "active_record"
require "./connect_db.rb"
require "date"

class Todo < ActiveRecord::Base
  def self.add_task(input_list)
    #Function to create new entry into todo table
    todo_task = input_list[:todo_text]
    last_date = Date.today + input_list[:due_in_days]
    Todo.create!(todo_text: todo_task, due_date: last_date, completed: false)
  end
  
  def self.show_list
    puts "My Todo-list\n\n"
    
    puts "Overdue"
    # FILL IN HERE
    puts "\n\n"
    
    puts "Due Today"
    # FILL IN HERE
    puts "\n\n"
    
    puts "Due Later"
    # FILL IN HERE
  end

end
