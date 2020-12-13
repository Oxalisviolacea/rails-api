class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoices, through: :invoice_items
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
end
