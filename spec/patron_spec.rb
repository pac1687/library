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

end
