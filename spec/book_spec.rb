require 'spechelper'

describe Book do

  it "will initialize with a book title" do
    test_book = Book.new({'title' => 'For Whom the Bell Tolls'})
    expect(test_book).to be_an_instance_of Book
  end

  it "will add the book title to the database" do
    test_book = Book.new({'title' => 'The Sun Also Rises'})
    test_book.save
    expect(Book.all).to eq [test_book]
  end

end
