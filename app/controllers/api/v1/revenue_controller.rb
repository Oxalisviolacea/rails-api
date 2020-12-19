class Api::V1::RevenueController < ApplicationController
  def total_revenue
    render json: RevenueSerializer.new(Merchant.total_revenue_between_(params))
  end

  def revenue_for_merchant
    render json: Merchant.revenue_by_merchant_(params[:id])
  end
end