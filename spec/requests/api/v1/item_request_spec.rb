require 'rails_helper'

describe 'Items API' do
  describe 'CRUD enpoints' do 
    it 'can send a list of items' do
      create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_successful

      json = JSON.parse(response.body, symbolize_names: true)

      items = json[:data]
      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    it 'can get one item by its id' do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      item = json[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
    end

    it 'can create a new item' do
      merchant1 = create(:merchant)
      item_params = {
        name: 'Test Item Name',
        description: 'Test Description',
        unit_price: 14.99,
        merchant_id: merchant1.id
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/items', headers: headers, params: JSON.generate(item_params)
      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
      expect(created_item.created_at.to_s).not_to be_empty
      expect(created_item.updated_at.to_s).not_to be_empty
    end

    it 'can update an existing item' do
      merchant1 = create(:merchant, id: 4)
      id = create(:item).id
      previous_name = Item.last.name
      previous_description = Item.last.description
      previous_unit_price = Item.last.unit_price
      previous_merchant_id = Item.last.id
      item_params = {
        name: 'Updated Item Name',
        description: 'Updated Item Description',
        unit_price: 23.45,
        merchant_id: merchant1.id
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq('Updated Item Name')
      expect(item.description).to_not eq(previous_description)
      expect(item.description).to eq('Updated Item Description')
      expect(item.unit_price).to_not eq(previous_unit_price)
      expect(item.unit_price).to eq(23.45)
      expect(item.merchant_id).to_not eq(previous_merchant_id)
      expect(item.merchant_id).to eq(merchant1.id)
    end

    it 'can destroy an item' do
      item = create(:item)

      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{item.id}"

      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'merchants endpoint' do
    it 'can return the merchant associated with an item' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchants"
      expect(response).to be_successful

      merchant_response = JSON.parse(response.body, symbolize_names: true)

      expect(merchant_response).to have_key(:data)
      expect(merchant_response[:data]).to be_an(Array)

      merchant_response[:data].each do |merchant_data|
        expect(merchant_data).to have_key(:id)
        expect(merchant_data[:id]).to be_a(String)
        expect(merchant_data[:id]).to eq(merchant.id.to_s)

        expect(merchant_data[:attributes]).to have_key(:name)
        expect(merchant_data[:attributes][:name]).to be_a(String)
        expect(merchant_data[:attributes][:name]).to eq(merchant.name)
      end
    end
  end
end
