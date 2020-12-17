class Api::V1::Items::SearchController < ApplicationController
  def index
    return nil if query(params).nil? || query(params).empty?

    render json: ItemSerializer.new(query(params))
  end

  def show
    return nil if query(params).nil? || query(params).empty?

    render json: ItemSerializer.new(query(params).first)
  end

  def query(params)
    if params[:name]
      Item.where('LOWER(name) LIKE ?', "%#{params[:name].downcase}%")
    elsif params[:description]
      Item.where('LOWER(description) LIKE ?', "%#{params[:description].downcase}%")
    elsif params[:unit_price]
      Item.where(unit_price: params[:unit_price])
    elsif params[:created_at]
      date = Date.parse(params[:created_at])
      Item.where(created_at: date.beginning_of_day..date.end_of_day)
    elsif params[:updated_at]
      date = Date.parse(params[:updated_at])
      Item.where(updated_at: date.beginning_of_day..date.end_of_day)
    end
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
