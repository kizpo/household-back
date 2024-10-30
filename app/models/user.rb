class User < ApplicationRecord
    has_many :categories
    has_many :transactions
    has_many :accounts
    belongs_to :organization, optional: true

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true

    has_secure_password
end
