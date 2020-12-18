class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  validates :name, presence: true

  def self.most_revenue(limit)
    Merchant
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .where("invoices.status='shipped' AND transactions.result='success'")
    .group("merchants.id")
    .order("revenue DESC")
    .limit(limit)
  end

  def self.most_items_sold(limit)
    Merchant
    .select("merchants.*, sum(invoice_items.quantity) as num_sold")
    .joins(invoices: [:invoice_items, :transactions])
    .where("invoices.status='shipped' AND transactions.result='success'")
    .group("merchants.id")
    .order("num_sold DESC")
    .limit(limit)
  end
end
