class Api::V1::Merchants::SearchController < ApplicationController
  def index
    return nil if query(params).nil? || query(params).empty?

    render json: MerchantSerializer.new(query(params))
  end

  def show
    return nil if query(params).nil? || query(params).empty?

    render json: MerchantSerializer.new(query(params).first)
  end

  def query(params)
    if params[:name]
      Merchant.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%")
    elsif params[:created_at]
      date = Date.parse(params[:created_at])
      Merchant.where(created_at: date.beginning_of_day..date.end_of_day)
    elsif params[:updated_at]
      date = Date.parse(params[:updated_at])
      Merchant.where(updated_at: date.beginning_of_day..date.end_of_day)
    end
  end

  private

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end
end
