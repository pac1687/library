require './lib/librarian'

class Patron < Librarian
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def ==(another_patron)
    self.name == another_patron.name && self.id == another_patron.id
  end

  def self.check_out_book(copy_id, patron_id)
    results = DB.exec("INSERT INTO checkouts (patron_id, copy_id) VALUES (#{patron_id}, #{copy_id}) RETURNING id;")
      @id = results.first['id'].to_i
  end

  def self.books(patron_id)
    books = []
    results = DB.exec("SELECT copies.* FROM patrons JOIN checkouts on (patrons.id = checkouts.patron_id) JOIN copies on (checkouts.copy_id = copies.id) WHERE patron_id = #{patron_id};")
    results.each do |result|
      book_id = result['book_id'].to_i
      name = DB.exec("SELECT name FROM books WHERE id = #{book_id};")
      book_name = name.first['name']
      books << book_name
    end
    books
  end


end
