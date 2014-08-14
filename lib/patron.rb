require './lib/librarian'

class Patron < Librarian
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def ==(another_patron)
    self.name == another_patron.name && self.id == another_patron.id
  end
end
