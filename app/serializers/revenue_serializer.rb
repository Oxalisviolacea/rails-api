class RevenueSerializer
  def self.merchant_revenue(rev)
    {
      "data":
      {
        "id": nil,
        "attributes": rev
      }
    }
  end
end