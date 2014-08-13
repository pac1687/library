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

end
