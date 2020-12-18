require 'rails_helper'

describe 'Merchants API' do
  describe 'Business intelligence enpoints' do
    before(:each) do
      @customer1 = create(:customer)
      @customer2 = create(:customer)
      @merchant1 = create(:merchant)
      @item1 = create(:item, merchant_id: @merchant1.id)
      @item2 = create(:item, merchant_id: @merchant1.id)
      @invoice1 = create(:invoice, status: 'shipped', customer_id: @customer1.id, merchant_id: @merchant1.id)
      @invoiceitem1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 15.00)
      @transaction1 = create(:transaction, invoice_id: @invoice1.id, result: 'success', created_at: 10.days.ago)
      @invoice2 = create(:invoice, status: 'shipped', customer_id: @customer2.id, merchant_id: @merchant1.id)
      @invoiceitem2 = create(:invoice_item, item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 15.00)
      @transaction2 = create(:transaction, invoice_id: @invoice2.id, result: 'success', created_at: 9.days.ago)

      @merchant2 = create(:merchant)
      @item3 = create(:item, merchant_id: @merchant2.id)
      @item4 = create(:item, merchant_id: @merchant2.id)
      invoice3 = create(:invoice, status: 'shipped', customer_id: @customer1.id, merchant_id: @merchant2.id)
      invoiceitem3 = create(:invoice_item, item_id: @item3.id, invoice_id: invoice3.id, quantity: 3, unit_price: 20.00)
      transaction3 = create(:transaction, invoice_id: invoice3.id, result: 'success', created_at: 8.days.ago)
      @invoice4 = create(:invoice, status: 'shipped', customer_id: @customer2.id, merchant_id: @merchant2.id)
      invoiceitem4 = create(:invoice_item, item_id: @item4.id, invoice_id: @invoice4.id, quantity: 4, unit_price: 20.00)
      transaction4 = create(:transaction, invoice_id: @invoice4.id, result: 'success', created_at: 7.days.ago)

      @merchant3 = create(:merchant)
      @item5 = create(:item, merchant_id: @merchant3.id)
      @item6 = create(:item, merchant_id: @merchant3.id)
      @invoice5 = create(:invoice, status: 'shipped', customer_id: @customer1.id, merchant_id: @merchant3.id)
      invoiceitem5 = create(:invoice_item, item_id: @item5.id, invoice_id: @invoice5.id, quantity: 5, unit_price: 10.00)
      transaction5 = create(:transaction, invoice_id: @invoice5.id, result: 'success', created_at: 6.days.ago)
      @invoice6 = create(:invoice, status: 'shipped', customer_id: @customer2.id, merchant_id: @merchant3.id)
      invoiceitem6 = create(:invoice_item, item_id: @item6.id, invoice_id: @invoice6.id, quantity: 6, unit_price: 10.00)
      transaction6 = create(:transaction, invoice_id: @invoice6.id, result: 'success', created_at: 5.days.ago)
    end

    it 'can find the merchants with the most revenue' do

      get '/api/v1/merchants/most_revenue?quantity=2'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      merchants = json[:data]

      expect(merchants.count).to eq(2)
      expect(merchants[0][:id]).to eq(@merchant2.id.to_s)
      expect(merchants[1][:id]).to eq(@merchant3.id.to_s)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)
        
        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'can find the merchants with the most items sold' do

      get '/api/v1/merchants/most_items?quantity=2'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      merchants = json[:data]

      expect(merchants.count).to eq(2)
      expect(merchants[0][:id]).to eq(@merchant3.id.to_s)
      expect(merchants[1][:id]).to eq(@merchant2.id.to_s)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)
        
        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'can return the total revenue between two dates' do

      get "/api/v1/revenue?start=#{10.days.ago}&end=#{8.days.ago}"

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data]).to eq('50')
    end

    it 'can return the merchant with the most revenue' do
      get '/api/v1/merchants/1/revenue'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[0][:revenue]).to eq('45')
      expect(json[:data][:attributes][:revenue]).to eq('45')
    end
  end
end
