require 'spechelper'

describe Author do

  it 'initializes and author with a name' do
    test_author = Author.new({'name' => "Ernest Hemingway"})
    expect(test_author).to be_an_instance_of Author
  end

  it 'adds an author to the database' do
    test_author = Author.new({'name' => "Ernest Hemingway"})
    test_author.save
    expect(Author.all).to eq [test_author]
  end

  it 'updates the authors name' do
    test_author = Author.new({'name' => "Dan Yellow"})
    test_author.save
    new_author_name = "Dan Brown"
    Author.update(new_author_name, test_author.id)
    new_author = Author.search_return_name(new_author_name)
    expect(new_author).to eq new_author_name
  end
end
