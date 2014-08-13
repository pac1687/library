require 'author'
require 'book'
require 'librarian'
require 'patron'
require 'authors_book'
require 'PG'
require 'pry'

DB = PG.connect({:dbname => 'test_library'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM authors_books *;")
    # DB.exec("DELETE FROM librarians *;")
    # DB.exec("DELETE FROM patrons *;")
    # DB.exec("DELETE FROM checkouts *;")
  end
end
