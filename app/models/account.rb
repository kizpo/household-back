class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  validates :name, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def update_balance
    total_expense = transactions.sum(:expense) || 0
    total_income = transactions.sum(:income) || 0
    new_balance = total_income - total_expense

    self.balance = [new_balance, 0].max

    save
  end

  def self.update_all_balances_for_user(user_id)
    accounts = where(user_id: user_id)
    accounts.each(&:update_balance)
  end

end
