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
  
  def self.mark_as_complete(input_todo_id)
    #Function to update todo list as complete
    todo_row = find(input_todo_id) #finding particular row from table
    todo_row.completed = true  #Updating complete field to completed for above selected row
    todo_row.save              # Saving the changes made to database
    return todo_row
  end
  
  def self.overdue
    where("last_date < ?", Date.today)
  end
  
  def to_display_list
    #Function to display todo in the desired format
    display_status = completed ? "[X]" : "[ ]"
    display_date = (last_date == Date.today) ? nil : last_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end
  
  def self.due_later
    where("last_date > ?", Date.today)
  end
  
  def self.due_today
    where("last_date = ?", Date.today)
  end
  
  def self.show_list
    puts "My Todo-list\n\n"
    
    puts "Overdue"
    puts overdue.map { |todo| todo.to_display_list }
    puts "\n\n"
    
    puts "Due Today"
    puts due_today.map { |todo| todo.to_display_list }
    puts "\n\n"
    
    puts "Due Later"
    puts due_later.map { |todo| todo.to_display_list }
  end

end
