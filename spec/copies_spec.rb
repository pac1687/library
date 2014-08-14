require "spechelper"

describe Copy do
  it 'initializes with a book id and the number of copies' do
    test_book = Book.new({'name' => 'The Sun Also Rises'})
    test_book.save
    new_copies = Copy.new({'book_id' => test_book.id, 'availability' => 'Y'})
    expect(new_copies).to be_an_instance_of Copy
  end

  it 'saves a book id and the number of copies to the database' do
    test_book = Book.new({'name' => 'The Sun Also Rises'})
    test_book.save
    new_copies = Copy.new({'book_id' => test_book.id, 'availability' => 'Y'})
    new_copies.save
    expect(Copy.all).to eq [new_copies]
  end

  it 'allows a user to search a book by name and see how many copies the library has' do
    test_book = Book.new({'name' => 'The Sun Also Rises'})
    test_book.save
    new_copy = Copy.new({'book_id' => test_book.id, 'availability' => 'Y'})
    new_copy.save
    new_copy1 = Copy.new({'book_id' => test_book.id, 'availability' => 'Y'})
    new_copy1.save
    test_search = "The Sun Also Rises"
    book_id = Book.search_return_id(test_search)
    copies = Copy.copy_count(book_id)
    expect(copies).to eq 2
  end

  it 'allows a user to search a book and see how many copies are available' do
    test_book = Book.new({'name' => 'The Sun Also Rises'})
    test_book.save
    new_copy = Copy.new({'book_id' => test_book.id, 'availability' => 'Y'})
    new_copy.save
    new_copy1 = Copy.new({'book_id' => test_book.id, 'availability' => 'N'})
    new_copy1.save
    test_search = "The Sun Also Rises"
    book_id = Book.search_return_id(test_search)
    available = Copy.available_count(book_id)
    expect(available).to eq 1
  end
end
