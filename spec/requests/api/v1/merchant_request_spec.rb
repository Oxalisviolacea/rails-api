require 'rails_helper'

describe 'Merchants API' do
  describe 'CRUD endpoints' do
    it 'can send a list of merchants' do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      merchants = json[:data]
      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'can get one merchant by its id' do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      merchant = json[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end

    it 'can create a new merchant' do
      merchant_params = {
        name: 'Test Merchant Name'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/merchants', headers: headers, params: JSON.generate(merchant_params)
      created_merchant = Merchant.last

      expect(response).to be_successful
      expect(created_merchant.name).to eq(merchant_params[:name])
      expect(created_merchant.created_at.to_s).not_to be_empty
      expect(created_merchant.updated_at.to_s).not_to be_empty
    end

    it 'can update an existing merchant' do
      id = create(:merchant).id
      previous_name = Merchant.last.name
      merchant_params = { name: 'Updated Merchant Name' }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate(merchant_params)
      merchant = Merchant.find_by(id: id)

      expect(response).to be_successful
      expect(merchant.name).to_not eq(previous_name)
      expect(merchant.name).to eq('Updated Merchant Name')
    end

    it 'can destroy an merchant' do
      merchant = create(:merchant)

      expect(Merchant.count).to eq(1)

      delete "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_successful
      expect(Merchant.count).to eq(0)
      expect { Merchant.find(merchant.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'items endpoint' do
    it 'can return all of the items associated with a merchant' do
      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_1.id)
      merchant_2 = create(:merchant)
      item_3 = create(:item, merchant_id: merchant_2.id)

      get "/api/v1/merchants/#{merchant_1.id}/items"
      expect(response).to be_successful

      items_response = JSON.parse(response.body, symbolize_names: true)

      expect(items_response).to have_key(:data)
      expect(items_response[:data]).to be_an(Array)
      expect(items_response[:data].count).to eq(2)

      expect(items_response[:data][0][:id]).to eq(item_1.id.to_s)
      item_attributes = items_response[:data][0][:attributes]
      expect(item_attributes[:name]).to eq(item_1.name)
      expect(item_attributes[:description]).to eq(item_1.description)
      expect(item_attributes[:unit_price]).to eq(item_1.unit_price)
      expect(item_attributes[:merchant_id]).to eq(merchant_1.id)

      items_response[:data].each do |item_data|
        expect(item_data).to have_key(:id)
        expect(item_data[:id]).to be_a(String)
        expect(item_data[:id]).to_not eq(item_1.id)

        expect(item_data[:attributes]).to have_key(:name)
        expect(item_data[:attributes][:name]).to be_a(String)
        expect(item_data[:attributes][:name]).to_not eq(item_3.name)
      end
    end
  end
end
