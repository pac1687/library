require "rubygems"
require "active_support/core_ext/string/inflections"
class Librarian

  def self.all
    table_name = self.table_name
    results = DB.exec("SELECT * FROM #{table_name};")
    all_objects = []
    results.each do |result|
      name = result['name']
      id = result['id']
      new_object = self.new({'name' => name, 'id' => id})
      all_objects << new_object
    end
    all_objects
  end

  def save
    table_name = self.class.table_name
    save = DB.exec("INSERT INTO #{table_name} (name) VALUES ('#{self.name}') RETURNING id;")
    @id = save.first['id'].to_i
  end

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.search_return_id(name)
    table_name = self.table_name
    results = DB.exec("SELECT * FROM #{table_name} WHERE name = '#{name}';")
    @id = results.first['id'].to_i
  end

  def self.search_return_name(name)
    table_name = self.table_name
    results = DB.exec("SELECT * FROM #{table_name} WHERE name = '#{name}';")
    @name = results.first['name']
  end

  def self.update(new_name, id)
    table_name = self.table_name
    results = DB.exec("UPDATE #{table_name} SET name = '#{new_name}' WHERE id = #{id};")
  end

  def self.delete(id)
    table_name = self.table_name
    DB.exec("DELETE FROM #{table_name} WHERE id = #{id}")
  end
end
