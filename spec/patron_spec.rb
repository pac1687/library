require "spechelper"

describe Patron do
  it 'will initialize with a name' do
    test_patron = Patron.new({'name' => 'Will Ferrell'})
    expect(test_patron).to be_an_instance_of Patron
  end

  it 'will save a new Patron to the database' do
    test_patron = Patron.new({'name' => 'Will Ferrell'})
    test_patron.save
    expect(Patron.all).to eq [test_patron]
  end

  it 'will allow a patron to check out a book' do
    test_patron = Patron.new({'name' => 'Will Ferrell'})
    test_patron.save
    test_book = Book.new({'name' => '100 jokes for kids'})
    test_book.save
    test_copy = Copy.new({'book_id' => test_book.id, 'availability' => 'Y'})
    test_copy.save
    test_book1 = Book.new({'name' => "Word Jokes for Comedians"})
    test_book1.save
    test_copy1 = Copy.new({'book_id' => test_book1.id, 'availability' => 'Y'})
    test_copy1.save
    Patron.check_out_book(test_copy.id, test_patron.id)
    Patron.check_out_book(test_copy1.id, test_patron.id)
    patron_books = Patron.books(test_patron.id)
    expect(patron_books).to eq [test_book.name, test_book1.name]
  end
end
