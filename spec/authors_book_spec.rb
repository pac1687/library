require "spechelper"

describe Authors_book do
  it "intitalizes with a book ID and author ID" do
    test_author_book = Authors_book.new({'book_id' => 3, 'author_id' => 2})
    expect(test_author_book).to be_an_instance_of Authors_book
  end

  it "saves the book with the author/s to the database" do
    test_author_book = Authors_book.new({'book_id' => 3, 'author_id' => 2})
    test_author_book.save
    expect(Authors_book.all).to eq [test_author_book]
  end

  it 'searches by author and returns books' do
    test_author = Author.new({'name' => "Ernest Hemingway"})
    test_author.save
    test_book = Book.new({'name' => "The Sun Also Rises"})
    test_book.save
    test_authors_book = Authors_book.new({'book_id' => test_book.id, 'author_id' => test_author.id})
    test_authors_book.save
    author_search = "Ernest Hemingway"
    author_id = Author.search_return_id(author_search)
    results = Authors_book.books_list_by_author(author_id)
    expect(results).to eq [test_book.name]
  end

  it "searches by name and returns authors" do
    test_author = Author.new({'name' => "Peggy Parish"})
    test_author.save
    test_book = Book.new({'name' => "Amelia Bedelia"})
    test_book.save
    test_authors_book = Authors_book.new({'book_id' => test_book.id, 'author_id' => test_author.id})
    test_authors_book.save
    book_name_search = "Amelia Bedelia"
    book_id = Book.search_return_id(book_name_search)
    results = Authors_book.authors_list_by_book(book_id)
    expect(results).to eq [test_author.name]
  end

  it "allows the user to enter multiple authors into the database" do
    test_author = Author.new({'name' => "God"})
    test_author1 = Author.new({'name' => "Moses"})
    test_author.save
    test_author1.save
    test_book = Book.new({'name' => "The Bible"})
    test_book.save
    test_author_book = Authors_book.new({'book_id' => test_book.id, 'author_id' => test_author.id})
    test_author_book.save
    test_author_book1 = Authors_book.new({'book_id' => test_book.id, 'author_id' => test_author1.id})
    test_author_book1.save
    book_name_search = "The Bible"
    book_id = Book.search_return_id(book_name_search)
    results = Authors_book.authors_list_by_book(book_id)
    expect(results).to eq [test_author.name, test_author1.name]
  end

  it "allows the user to delete a book/author combination from the database" do
    test_author_book = Authors_book.new({'book_id' => 3, 'author_id' => 2})
    test_author_book.save
    Authors_book.delete(test_author_book.id)
    expect(Authors_book.all).to eq []
  end
end
