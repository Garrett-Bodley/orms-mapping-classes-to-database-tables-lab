class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn] 
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end

  def self.create(name:, grade:)
    self.new(name, grade).tap do |student|
      student.save
    end
  end

  def save
    sql = <<-SQL
      INSERT INTO students (id, name, grade) VALUES (?, ?, ?);
    SQL
    DB[:conn].execute(sql, self.id, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

end

# Student
#   responds to a getter for :id (FAILED - 1)
#   does not provide a setter for :id (FAILED - 2)
#   when initialized with a name and a grade
#     the name attribute can be accessed (FAILED - 3)
#     the grade attribute can be accessed (FAILED - 4)
#   .create_table
#     creates the students table in the database (FAILED - 5)
#   .drop_table
#     drops the students table from the database (FAILED - 6)
#   #save
#     saves an instance of the Student class to the database (FAILED - 7)
#   .create
#     takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database (FAILED - 8)
#     returns the new object that it instantiated (FAILED - 9)