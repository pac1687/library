class Author
  attr_reader :id, :name

  def initialize(attributes)
    @id = attributes['id'].to_i
    @name = attributes['name']
  end

  def ==(another_author)
    self.id == another_author.id && self.name == another_author.name
  end

  def save
    results = DB.exec("INSERT INTO authors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM authors;")
    authors = []
    results.each do |result|
      new_author = Author.new(result)
      authors << new_author
    end
    authors
  end
end
