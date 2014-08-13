class Book
  attr_reader :id, :title

  def initialize(attributes)
    @id = attributes['id'].to_i
    @title = attributes['title']
  end

  def ==(another_book)
    self.id == another_book.id && self.title == another_book.title
  end

  def save
    results = DB.exec("INSERT INTO books (title) VALUES ('#{@title}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM books;")
    books = []
    results.each do |result|
      new_book = Book.new(result)
      books << new_book
    end
    books
  end

  def self.search(book_title)
    results = DB.exec("SELECT * FROM books WHERE title = '#{book_title}';")
    @id = results.first['id'].to_i
  end
end
