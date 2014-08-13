require "./lib/Librarian"

class Book < Librarian
  attr_reader :id, :name

  def initialize(attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
  end

  def ==(another_book)
    self.id == another_book.id && self.name == another_book.name
  end

  # def save
  #   results = DB.exec("INSERT INTO books (name) VALUES ('#{@name}') RETURNING id;")
  #   @id = results.first['id'].to_i
  # end

  # def self.all
  #   results = DB.exec("SELECT * FROM books;")
  #   books = []
  #   results.each do |result|
  #     new_book = Book.new(result)
  #     books << new_book
  #   end
  #   books
  # end

  # def self.search(book_name)
  #   results = DB.exec("SELECT * FROM books WHERE name = '#{book_name}';")
  #   @id = results.first['id'].to_i
  # end
end
