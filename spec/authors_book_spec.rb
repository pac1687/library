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

end
