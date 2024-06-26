
Ruby MySQL Database Interaction Script

This Ruby script, facilitates communication with a MySQL database. The program is designed to connect to a MySQL server, create a database and multiple tables, insert data, and display the results. 
It ensures re-runnability by dropping the database if it already exists before creating a new one.

Usage

To execute the script, run the following command in your terminal:
    ruby lab5.rb

Dependencies

Ensure you have the Ruby MySQL2 library installed. You can install it using the following command:
    sudo apt-get install ruby-mysql2

Notes

Modify the database connection parameters in the script to match your local MySQL setup.

Code Overview

1. Connecting to MySQL Server:
   - The script connects to the MySQL server using the provided host, username, and password.

2. Database Management:
   - It drops the existing database named TTU if it exists and creates a new one.

3. Table Creation:
   - Creates a students table with attributes such as TNumber, firstname, lastname, dateofbirth, and credits.
   - Inserts predefined data into the students table.

4. Data Output:
   - Outputs the contents of the students table in a neatly formatted manner.

5. Additional Table Creation:
   - Creates a grades table with attributes including TNumber, CourseID, Semester, Year, and Grade.
   - Inserts predefined data into the grades table.

6. Data Output:
   - Outputs the contents of the grades table in a neatly formatted manner.

7. Closing Connection:
   - Ends the server connection gracefully.

Example Output

The script will produce a formatted output displaying the contents of the students and grades tables, showcasing the data inserted during execution.

    Tnumber     FirstName   Lastname   DateOfBirth   Credits
    T1234567    Nathan      Summers    1990-03-12    45.00
    T5567645    Johnny      Blaze      1972-08-15    36.00
    T7891011    Jean        Summers    1963-09-01    120.00
    T7654321    Peter       Parker     1962-05-23    51.00
    T6677889    Wade        Wilson     1990-02-11    72.00

    TNumber     CourseID    Semester    Year   Grade
    T1234567    CSC3040     Fall        2013   B
    T7891011    MAT1910     Fall        2011   A
    T5567645    CSC1300     Spring      2013   C
    T6677889    MAT1910     Spring      2012   A
    T7891011    CSC1300     Spring      2012   F
