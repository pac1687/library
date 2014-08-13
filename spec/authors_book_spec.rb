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
    test_book = Book.new({'title' => "The Sun Also Rises"})
    test_book.save
    test_authors_book = Authors_book.new({'book_id' => test_book.id, 'author_id' => test_author.id})
    test_authors_book.save
    author_search = "Ernest Hemingway"
    author_id = Author.search(author_search)
    results = Authors_book.books_list_by_author(author_id)
    expect(results).to eq [test_book.title]
  end

  it "searches by title and returns authors" do
    test_author = Author.new({'name' => "Peggy Parish"})
    test_author.save
    test_book = Book.new({'title' => "Amelia Bedelia"})
    test_book.save
    test_authors_book = Authors_book.new({'book_id' => test_book.id, 'author_id' => test_author.id})
    test_authors_book.save
    title_search = "Amelia Bedelia"
    book_id = Book.search(title_search)
    results = Authors_book.authors_list_by_book(book_id)
    expect(results).to eq [test_author.name]
  end
end
