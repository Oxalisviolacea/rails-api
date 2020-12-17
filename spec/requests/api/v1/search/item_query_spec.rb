require 'rails_helper'

describe 'Items API' do
  describe 'the find_all endpoint' do
    it 'can find all items matching a name search' do
      create(:item, name: 'Small COFFEE')
      create(:item, name: 'Large coffee')
      item3 = create(:item, name: 'Chocolate croissant')

      get '/api/v1/items/find_all?name=cof'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      items = json[:data]
      expect(items.count).to eq(2)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        expect(item[:id]).to_not eq(item3.id)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end
    end

    it 'will return a 204 if there are no name matches' do
      create(:item, name: 'Small COFFEE')
      create(:item, name: 'Large coffee')
      create(:item, name: 'Chocolate croissant')

      get '/api/v1/items/find_all?name=xyz'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find all items matching a description search' do
      create(:item, description: 'PURPLE aluminum')
      create(:item, description: 'purple fabric')
      item3 = create(:item, description: 'orange plastic')

      get '/api/v1/items/find_all?description=Purp'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      items = json[:data]
      expect(items.count).to eq(2)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        expect(item[:id]).to_not eq(item3.id)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end
    end

    it 'will return a 204 if there are no description matches' do
      create(:item, description: 'PURPLE aluminum')
      create(:item, description: 'purple fabric')
      create(:item, description: 'orange plastic')

      get '/api/v1/items/find_all?description=xyz'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find all items matching a unit_price search' do
      create(:item, unit_price: 99)
      create(:item, unit_price: 99.00)
      item3 = create(:item, unit_price: 33.12)

      get '/api/v1/items/find_all?unit_price=99.00'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      items = json[:data]
      expect(items.count).to eq(2)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        expect(item[:id]).to_not eq(item3.id)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end
    end

    it 'will return a 204 if there are no unit_price matches' do
      create(:item, unit_price: 99)
      create(:item, unit_price: 99.00)
      create(:item, unit_price: 33.12)

      get '/api/v1/items/find_all?unit_price=45'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find all items matching a created_at date search' do
      create(:item, created_at: Date.today)
      create(:item, created_at: Date.today)
      item3 = create(:item, created_at: 10.days.ago)

      get "/api/v1/items/find_all?created_at=#{Date.today}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      items = json[:data]
      expect(items.count).to eq(2)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        expect(item[:id]).to_not eq(item3.id)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end
    end

    it 'will return a 204 if there are no created_at matches' do
      create(:item, created_at: Date.today)
      create(:item, created_at: Date.today)
      create(:item, created_at: 10.days.ago)

      get "/api/v1/items/find_all?created_at=#{5.days.ago}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find all items matching a updated_at date search' do
      create(:item, updated_at: Date.today)
      create(:item, updated_at: Date.today)
      item3 = create(:item, updated_at: 10.days.ago)

      get "/api/v1/items/find_all?updated_at=#{Date.today}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      items = json[:data]
      expect(items.count).to eq(2)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        expect(item[:id]).to_not eq(item3.id)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end
    end

    it 'will return a 204 if there are updated_at matches' do
      create(:item, updated_at: Date.today)
      create(:item, updated_at: Date.today)
      create(:item, updated_at: 10.days.ago)

      get "/api/v1/items/find_all?updated_at=#{5.days.ago}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end

  describe 'the find endpoint' do
    it 'can find one item matching a name search' do
      create(:item, name: 'Small COFFEE')
      create(:item, name: 'Large coffee')
      item3 = create(:item, name: 'Chocolate croissant')

      get '/api/v1/items/find?name=cof'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json.count).to eq(1)

      item = json[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      expect(item[:id]).to_not eq(item3.id)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end

    it 'will return a 204 if there are no name matches' do
      create(:item, name: 'Small COFFEE')
      create(:item, name: 'Large coffee')
      create(:item, name: 'Chocolate croissant')

      get '/api/v1/items/find?name=xyz'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find one item matching a description search' do
      create(:item, description: 'PURPLE aluminum')
      create(:item, description: 'purple fabric')
      item3 = create(:item, description: 'orange plastic')

      get '/api/v1/items/find?description=Purp'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json.count).to eq(1)

      item = json[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      expect(item[:id]).to_not eq(item3.id)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end

    it 'will return a 204 if there are no description matches' do
      create(:item, description: 'PURPLE aluminum')
      create(:item, description: 'purple fabric')
      create(:item, description: 'orange plastic')

      get '/api/v1/items/find?description=xyz'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find one item matching a unit_price search' do
      create(:item, unit_price: 99)
      create(:item, unit_price: 99.00)
      item3 = create(:item, unit_price: 33.12)

      get '/api/v1/items/find?unit_price=99.00'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json.count).to eq(1)

      item = json[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      expect(item[:id]).to_not eq(item3.id)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end

    it 'will return a 204 if there are no unit_price matches' do
      create(:item, unit_price: 99)
      create(:item, unit_price: 99.00)
      create(:item, unit_price: 33.12)

      get '/api/v1/items/find?unit_price=45'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find all items matching a created_at date search' do
      create(:item, created_at: Date.today)
      create(:item, created_at: Date.today)
      item3 = create(:item, created_at: 10.days.ago)

      get "/api/v1/items/find?created_at=#{Date.today}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json.count).to eq(1)

      item = json[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      expect(item[:id]).to_not eq(item3.id)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end

    it 'will return a 204 if there are no created_at matches' do
      create(:item, created_at: Date.today)
      create(:item, created_at: Date.today)
      create(:item, created_at: 10.days.ago)

      get "/api/v1/items/find?created_at=#{5.days.ago}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find all items matching a updated_at date search' do
      create(:item, updated_at: Date.today)
      create(:item, updated_at: Date.today)
      item3 = create(:item, updated_at: 10.days.ago)

      get "/api/v1/items/find?updated_at=#{Date.today}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json.count).to eq(1)

      item = json[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      expect(item[:id]).to_not eq(item3.id)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end

    it 'will return a 204 if there are updated_at matches' do
      create(:item, updated_at: Date.today)
      create(:item, updated_at: Date.today)
      create(:item, updated_at: 10.days.ago)

      get "/api/v1/items/find?updated_at=#{5.days.ago}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end

  describe 'if an incorrect attribute is entered' do
    it 'the status is a 204' do
      create(:item)
      create(:item)
      create(:item)

      get '/api/v1/items/find?bogus_search=xyz'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end
end
