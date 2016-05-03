require './lib/person'

class Bank

  attr_reader :bank_name, :account_members

  def initialize(name)
    @bank_name = name
    @account_members = []
    @total_funds = 0
  end

  def open_account(person)
    account_members << person
    person.accounts.store(bank_name, person.balances)
  end

  def deposit(person, amount)
    if person.cash < amount
      "Transaction failed"
    else
      person.balances += amount
      person.accounts[bank_name] += amount
      person.cash -= amount
      @total_funds += amount
    end
  end

  def withdrawal(person, amount)
    if person.balances < amount
      "Insufficent Funds"
    else
      person.balances -= amount
      person.cash += amount
      @total_funds -= amount
    end
  end

  def transfer(person, bank, amount)
    if person.accounts[bank.bank_name].nil?
      "No account found"
    elsif person.accounts[self.bank_name] < amount
      "Insufficient funds"
    else
      person.accounts[self.bank_name] -= amount
      person.accounts[bank.bank_name] += amount
      @total_funds -= amount
    end
  end

  def total_cash
    @total_funds
  end

end
