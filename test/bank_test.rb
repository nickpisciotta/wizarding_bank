require 'minitest/autorun'
require 'minitest/pride'
require './lib/bank'
require './lib/person'

  class BankTest < Minitest::Test

    def test_bank_has_name
      chase = Bank.new("JP Morgan Chase")

      assert_equal "JP Morgan Chase", chase.bank_name
    end

    def test_bank_can_create_new_accounts
      chase = Bank.new("JP Morgan Chase")
      person1 = Person.new("Minerva", 1000)
      chase.open_account(person1)

      assert_equal [person1], chase.account_members
    end

    def test_bank_can_accept_deposits
      chase = Bank.new("JP Morgan Chase")
      person1 = Person.new("Minerva", 1000)
      chase.open_account(person1)
      chase.deposit(person1, 750)

      assert_equal 750, person1.balances
      assert_equal 250, person1.cash
    end

    def test_bank_can_take_multiple_clients
      chase = Bank.new("JP Morgan Chase")
      person1 = Person.new("Minerva", 1000)
      person2 = Person.new("Luna", 500)
      chase.open_account(person1)
      chase.open_account(person2)

      assert_equal [person1, person2], chase.account_members
    end

    def test_bank_can_make_multiple_deposits
      chase = Bank.new("JP Morgan Chase")
      person1 = Person.new("Minerva", 1000)
      person2 = Person.new("Luna", 500)
      chase.open_account(person1)
      chase.open_account(person2)
      chase.deposit(person1, 500)
      chase.deposit(person2, 250)

      assert_equal 500, person1.balances
      assert_equal 250, person2.balances
    end

    def test_client_can_make_multiple_deposits
      chase = Bank.new("JP Morgan Chase")
      person1 = Person.new("Minerva", 1000)
      chase.open_account(person1)
      chase.deposit(person1, 100)
      chase.deposit(person1, 100)

      assert_equal 800, person1.cash
      assert_equal 200, person1.balances
    end

    def test_client_cannot_deposit_more_cash_than_they_have
      chase = Bank.new("JP Morgan Chase")
      person1 = Person.new("Minerva", 1000)
      chase.open_account(person1)

      assert_equal "Transaction failed", chase.deposit(person1, 2000)
    end

    def test_client_can_withdraw_funds_mutliple_times
      chase = Bank.new("JP Morgan Chase")
      person1 = Person.new("Minerva", 1000)
      chase.open_account(person1)
      chase.deposit(person1, 500)
      chase.withdrawal(person1, 100)
      chase.withdrawal(person1, 100)

      assert_equal 700, person1.cash
      assert_equal 300, person1.balances
    end

    def test_client_can_open_multiple_accounts
      chase = Bank.new("JP Morgan Chase")
      wells_fargo = Bank.new("Wells Fargo")
      person1 = Person.new("Minerva", 1000)
      chase.open_account(person1)
      wells_fargo.open_account(person1)

      assert_equal ["JP Morgan Chase", "Wells Fargo"], person1.accounts.keys
    end

    def test_client_can_transer_funds_from_one_account_to_another
      chase = Bank.new("JP Morgan Chase")
      wells_fargo = Bank.new("Wells Fargo")
      person1 = Person.new("Minerva", 1000)
      chase.open_account(person1)
      wells_fargo.open_account(person1)
      chase.deposit(person1, 100)
      wells_fargo.deposit(person1, 100)
      chase.transfer(person1, wells_fargo, 100)

      assert_equal 800, person1.cash
      assert_equal 200, person1.accounts["Wells Fargo"]
    end

    def test_client_cannot_transer_more_than_bank_balance
      chase = Bank.new("JP Morgan Chase")
      wells_fargo = Bank.new("Wells Fargo")
      person1 = Person.new("Minerva", 1000)
      chase.open_account(person1)
      wells_fargo.open_account(person1)
      chase.deposit(person1, 100)
      wells_fargo.deposit(person1, 100)
      result = chase.transfer(person1, wells_fargo , 200)


      assert_equal "Insufficient funds", result
    end

    def test_total_cash_returns_total_for_bank
      chase = Bank.new("JP Morgan Chase")
      wells_fargo = Bank.new("Wells Fargo")
      person1 = Person.new("Minerva", 1000)
      chase.open_account(person1)
      wells_fargo.open_account(person1)
      chase.deposit(person1, 100)
      chase.deposit(person1, 100)
      chase.withdrawal(person1, 50)
      chase.transfer(person1, wells_fargo, 50)

      assert_equal 100, chase.total_cash
    end

  end
