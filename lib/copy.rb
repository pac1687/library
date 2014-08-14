require "./lib/Librarian"

class Copy
  attr_reader :id, :book_id, :availability

  def initialize(attributes)
    @id = attributes['id'].to_i
    @availability = attributes['availability']
    @book_id = attributes['book_id'].to_i
  end

  def ==(another_copies)
    self.id == another_copies.id && self.book_id == another_copies.book_id && self.availability == another_copies.availability
  end

  def save
    results = DB.exec("INSERT INTO copies (book_id, availability) VALUES (#{book_id}, '#{availability}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM copies;")
    copies = []
    results.each do |result|
      new_copies = Copy.new(result)
      copies << new_copies
    end
    copies
  end

  def self.copy_count(book_id)
    results = DB.exec("SELECT COUNT(book_id) FROM copies WHERE book_id = #{book_id};")
    @copies = results.first['count'].to_i
  end

  def self.available_count(book_id)
    results = DB.exec("SELECT COUNT(book_id) FROM copies WHERE availability = 'Y' AND book_id = #{book_id};")
    @available = results.first['count'].to_i
  end
end

#It lists all copies of book
#patron chooses which copy
#insert that info into the checkouts table
#Mark copy unavailable in copies table.
