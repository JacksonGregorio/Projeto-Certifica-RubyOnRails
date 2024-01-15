class Certificate < ApplicationRecord
  belongs_to :companies, optional: true
  belongs_to :company, optional: true

  validates :title, presence: true
  validates :validity, presence: true
  validates :value, presence: true
  validates :cnpj, presence: true
  validates :company_id, presence: true

end
