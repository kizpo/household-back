class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :account

  validates :date, presence: true
  validates :name, presence: true
  validates :expense, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :income, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validate :either_expense_or_income
  validate :user_owns_account

  after_save :update_all_account_balances
  after_destroy :update_all_account_balances

  private

  def either_expense_or_income
    if expense.blank? && income.blank?
      errors.add(:base, "支出または収入のいずれかを入力してください")
    end
  end

  def user_owns_account
    unless account.user_id == user_id
      errors.add(:account_id, "選択した口座はこのユーザーに紐づいていません")
    end
  end

  def update_all_account_balances
    Account.update_all_balances_for_user(user_id)
  end
end
