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

    Merchant.select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue").joins(invoices: [:invoice_items, :transactions]).where("invoices.status='shipped' AND transactions.result='success'").group("merchants.id").order("revenue DESC").limit(2)
  end
end
