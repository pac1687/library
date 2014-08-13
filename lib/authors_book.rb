class Authors_book
  attr_reader :id, :book_id, :author_id

  def initialize(attributes)
    @id = attributes['id'].to_i
    @book_id = attributes['book_id'].to_i
    @author_id = attributes['author_id'].to_i
  end

  def ==(another_authors)
    self.id == another_authors.id && self.book_id == another_authors.book_id && self.author_id == another_authors.author_id
  end

  def save
    results = DB.exec("INSERT INTO authors_book (book_id, author_id) VALUES (#{book_id}, #{author_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM authors_book;")
    authors_book = []
    results.each do |result|
      new_authors_book = Authors_book.new(result)
      authors_book << new_authors_book
    end
    authors_book
  end

  def self.books_list_by_author(author_id)
    results = DB.exec("SELECT books.* FROM authors JOIN authors_book ON(authors.id = authors_book.author_id) JOIN books ON (authors_book.book_id = books.id) WHERE authors.id = #{author_id};")
    books = []
    results.each do |result|
      new_book = Book.new(result)
      books << new_book.title
    end
    books
  end

  def self.authors_list_by_book(book_id)
    # binding.pry
    results = DB.exec("SELECT authors.* FROM books JOIN authors_book ON (books.id = authors_book.book_id) JOIN authors ON (authors_book.author_id = authors.id) WHERE books.id = #{book_id};")
    authors = []
    results.each do |result|
      new_author = Author.new(result)
      authors << new_author.name
    end
    authors
  end
end
