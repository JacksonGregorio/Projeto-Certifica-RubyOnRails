class Company < ApplicationRecord
    has_many :certificates
    has_many :users
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :cnpj, presence: true, uniqueness: true
end
