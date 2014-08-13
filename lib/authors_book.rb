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


end
