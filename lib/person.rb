class Person

  attr_accessor :name, :cash, :accounts, :balances

  def initialize(name, cash = nil)
    @name = name
    @cash = cash
    @accounts = {}
    @balances = 0
  end

  
end
