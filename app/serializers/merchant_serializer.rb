class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  has_many :invoices
  has_many :items
end
