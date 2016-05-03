require 'minitest/autorun'
require 'minitest/pride'
require './lib/person'

class PersonTest < Minitest::Test

  def test_person_has_name_and_cash
    person1 = Person.new("Minerva", 1000)
    person2 = Person.new("Luna", 500)

    assert_equal "Minerva", person1.name
    assert_equal 1000, person1.cash
    assert_equal "Luna", person2.name
    assert_equal 500, person2.cash
  end
  
end
