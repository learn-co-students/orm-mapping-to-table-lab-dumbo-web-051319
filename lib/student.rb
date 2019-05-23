require "pry"
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id
  def initialize(name, grade)
    @name = name
    @grade = grade
    # @id = id
  end
  def self.create_table
    sql = <<-SQL
        create table students (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          grade TEXT
        );
    SQL
    DB[:conn].execute(sql)
  end
  def self.drop_table
    sql = <<-SQL
        DROP TABLE "students";
    SQL
    DB[:conn].execute(sql)
  end
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES ('#{self.name}', '#{self.grade}');
    SQL
    DB[:conn].execute(sql)
    data_hash = DB[:conn].execute("SELECT * FROM students WHERE students.name = '#{self.name}'")
    # self.id = data_hash[0][0]
  end
  def self.create(data_hash)
    student = self.new(data_hash[:name],data_hash[:grade])
    student.save
    return student
  end
end
