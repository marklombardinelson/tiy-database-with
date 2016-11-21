require 'csv'
# Create a class for people
class Person
  attr_accessor :name, :phone_number, :address, :position, :salary, :slack_account, :github_account

  # Initialize  varible needed to be tracked.
  def initialize(name)
    @name = name
  end
end

#   # Make an array to call all of the names created
class Database
  def initialize
    @people = []

    # Add stuff here to load people from CSV file
    CSV.foreach("people.csv", headers:true) do |person|
      name = person["name"]
      phone = person["phone_number"]
      address = person["address"]
      position = person["position"]
      salary = person["salary"]
      slack = person["slack"]
      github = person["github"]

      add_to_database(name, phone, address, position, salary, slack, github)
    end
  end

  def save_database
    # Write something to save people to CSV file
    csv = CSV.open("people.csv", "w")
    csv.add_row %w{name phone address position salary slack github}

    @people.each do |person|
      csv.add_row [person.name, person.phone_number, person.address, person.position, person.salary, person.slack_account, person.github_account]
    end
    csv.close
  end

  def add_to_database (name, phone_number, address, position, salary, slack_account, github_account)
    person = Person.new(name)
    person.address = address
    person.position = position
    person.phone_number = phone_number
    person.salary = salary
    person.slack_account = slack_account
    person.github_account = github_account
    @people << person
  end

  def new_menu_report
    @people.each do |person|
      puts "Name: #{person.name} | Phone Number:#{person.phone_number} | Address: #{person.address}| Position: #{person.position} | Salary: #{person.salary} | Slack Account: #{person.slack_account} | Github Account: #{person.github_account}"
    end
  end
  # Make sure this gets called when the program ends
  # Ask for a person

  def person_prompt
    puts "We know all the people. Do you want to Add (A), Seach (S), or Delete (D) someone?"
    gets.chomp
  end

  # define the Add, Search, and Delete method into the  people class
  def menu
    loop do
      response = person_prompt
      case response

      when "A"
        puts "Name"
        name = gets.chomp

        person = Person.new(name)

        puts "Phone Number"
        person.phone_number = gets.chomp

        puts "Adress: "
        person.address = gets.chomp

        puts "Position (Instructor, Ops, Campus Director, Student): "
        person.position = gets.chomp

        puts "Salary: "
        person.salary = gets.chomp.to_i

        puts "Slack Account: "
        person.slack_account = gets.chomp

        puts "Github Account: "
        person.github_account = gets.chomp

        @people << person

        save_database

      when "S"
        # Ask the user what name they want to search for
        puts "Who are you looking for?"
        name_search_prompt = gets.chomp
        # Look through the list of people and make a new list of people that have that name
        results_of_searching = @people.select do |person|
          # this should evaluate to true if this person ends up in the results
          person.name == name_search_prompt
        end
        # Go through our resulting list and print each person
        results_of_searching.each do |person|
          puts "You found #{person.name}"
          puts person.name
          puts person.phone_number
          puts person.address
          puts person.position
          puts person.slack_account
          puts person.github_account
        end
      when "D"

        puts "Who are we getting rid of"
        delete_name_prompt = gets.chomp

        results_of_deleting = @people.select do |person|
          person.name == delete_name_prompt
        end

        results_of_deleting.each do |person|
          puts "You deleted #{person.name}"
          break
        end
      end
    end
  end
end
my_database = Database.new
my_database.menu
