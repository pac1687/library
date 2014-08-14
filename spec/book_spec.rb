require 'spechelper'

describe Book do

  it "will initialize with a book name" do
    test_book = Book.new({'name' => 'For Whom the Bell Tolls'})
    expect(test_book).to be_an_instance_of Book
  end

  it "will add the book name to the database" do
    test_book = Book.new({'name' => 'The Sun Also Rises'})
    test_book.save
    expect(Book.all).to eq [test_book]
  end

  it 'will update a books name in the database' do
    test_book = Book.new({'name' => 'The Gun Also Rises'})
    test_book.save
    new_book_name = "The Sun Also Rises"
    Book.update(new_book_name, test_book.id)
    new_book = Book.search_return_name(new_book_name)
    expect(new_book).to eq new_book_name
  end
end
