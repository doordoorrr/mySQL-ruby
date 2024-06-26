#!/usr/bin/env ruby

=begin
    author: alexandria Burchfiel 
    date: 6/24/24
    purpose: ruby program to communicate with MySQL database to connect +
    create a DB, create several tables, insert data, and output. 
    To ensure the program can run multiple times without errors, it drops the database if it already exists before creating a new one.
    
    usage: ruby lab5.rb
    dependencies: ensure you have the ruby MySQL2 library installed. you can install it using the following command: $ sudo apt-get install ruby-mysql2
    note: modify the database connection parameters to match your local MySQL setup

=end 


require 'mysql2'


# connect to server 
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "coursework")


#code line for program re-runnability 
client.query("DROP DATABASE IF EXISTS TTU") 


# creates TTU db
client.query("CREATE DATABASE TTU")
client.query("USE TTU")


# creates Students ( w attributes and restraints, types)
client.query(<<-SQL
  CREATE TABLE students (
    TNumber CHAR(8) PRIMARY KEY,   
    firstname VARCHAR(10) NOT NULL,
    lastname VARCHAR(10) NOT NULL,
    dateofbirth DATE,
    credits DECIMAL(5, 2),
    CHECK (TNumber REGEXP '^T[0-9]{7}$')
  ) ENGINE=INNODB;
SQL
)


# data in students is correct
students = [
  ["T1234567", "Nathan", "Summers", "1990-03-12", 45],
  ["T5567645", "Johnny", "Blaze", "1972-08-15", 36],
  ["T7891011", "Jean", "Summers", "1963-09-01", 120],
  ["T7654321", "Peter", "Parker", "1962-05-23", 51],
  ["T6677889", "Wade", "Wilson", "1990-02-11", 72]
]

#inserts data into students table w query 
students.each do |student|
  client.query("INSERT INTO students (TNumber, firstname, lastname, dateofbirth, credits) VALUES ('#{student[0]}', '#{student[1]}', '#{student[2]}', '#{student[3]}', #{student[4]})")
end


# prints results of a SELECT ALL statement
    # neat output when printing
results = client.query("SELECT * FROM students")
puts "Tnumber\t\tFirstName\tLastname\tDateOfBirth\tCredits"
results.each do |row|
    puts "#{row['TNumber']}\t#{row['firstname']}\t\t#{row['lastname']}\t\t#{row['dateofbirth']}\t#{'%.2f' % row['credits']}"
end
 
# creates Grades ( w attributes and restraints, FOREIGN KEYYYYS)
client.query(<<-SQL
  CREATE TABLE grades (
    TNumber CHAR(8),
    CourseID CHAR(7),
    Semester VARCHAR(6),
    Year YEAR,
    Grade CHAR(1),
    CHECK (TNumber REGEXP '^T[0-9]{7}$'),
    CHECK (Semester IN ('Winter', 'Summer', 'Fall', 'Spring')),
    FOREIGN KEY (TNumber) REFERENCES students(TNumber)
  ) ENGINE=INNODB;
SQL
)

# data in Grades is correct
grades = [
  ["T1234567", "CSC3040", "Fall", 2013, "B"],
  ["T7891011", "MAT1910", "Fall", 2011, "A"],
  ["T5567645", "CSC1300", "Spring", 2013, "C"],
  ["T6677889", "MAT1910", "Spring", 2012, "A"],
  ["T7891011", "CSC1300", "Spring", 2012, "F"]
]

grades.each do |grade|
  client.query("INSERT INTO grades (TNumber, CourseID, Semester, Year, Grade) VALUES ('#{grade[0]}', '#{grade[1]}', '#{grade[2]}', #{grade[3]}, '#{grade[4]}')")
end

puts "\n\n"

# prints results of a SELECT ALL statement
    # neat output when printing
results = client.query("SELECT * FROM grades")

puts "TNumber\t\tCourseID\tSemester\tYear\tGrade"
results.each do |row|
  puts "#{row['TNumber']}\t#{row['CourseID']}\t\t#{row['Semester']}\t\t#{row['Year']}\t#{row['Grade']}"
end

#end server connection
client.close if client
