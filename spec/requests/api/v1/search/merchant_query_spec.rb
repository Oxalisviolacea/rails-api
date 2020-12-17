require 'rails_helper'

describe 'Merchants API' do
  describe 'the find_all endpoint' do
    it 'can find all merchants matching a name search' do
      create(:merchant, name: "JUNK n' STUFF")
      create(:merchant, name: 'junk yard')
      merchant3 = create(:merchant, name: 'Merchandise')

      get '/api/v1/merchants/find_all?name=ju'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      merchants = json[:data]
      expect(merchants.count).to eq(2)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)
        expect(merchant[:id]).to_not eq(merchant3.id)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'will return a 204 if there are no name matches' do
      create(:merchant, name: "JUNK n' STUFF")
      create(:merchant, name: 'junk yard')
      create(:merchant, name: 'Merchandise')

      get '/api/v1/items/find_all?name=xyz'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find all merchants matching a created_at date search' do
      create(:merchant, created_at: Date.today)
      create(:merchant, created_at: Date.today)
      merchant3 = create(:merchant, created_at: 10.days.ago)

      get "/api/v1/merchants/find_all?created_at=#{Date.today}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      merchants = json[:data]
      expect(merchants.count).to eq(2)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)
        expect(merchant[:id]).to_not eq(merchant3.id)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'will return a 204 if there are no created_at matches' do
      create(:merchant, created_at: Date.today)
      create(:merchant, created_at: Date.today)
      create(:merchant, created_at: 10.days.ago)

      get "/api/v1/merchants/find_all?created_at=#{5.days.ago}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find all merchants matching a updated_at date search' do
      create(:merchant, updated_at: Date.today)
      create(:merchant, updated_at: Date.today)
      merchant3 = create(:merchant, updated_at: 10.days.ago)

      get "/api/v1/merchants/find_all?updated_at=#{Date.today}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      merchants = json[:data]
      expect(merchants.count).to eq(2)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)
        expect(merchant[:id]).to_not eq(merchant3.id)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'will return a 204 if there are updated_at matches' do
      create(:merchant, updated_at: Date.today)
      create(:merchant, updated_at: Date.today)
      create(:merchant, updated_at: 10.days.ago)

      get "/api/v1/merchants/find_all?updated_at=#{5.days.ago}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end

  describe 'the find endpoint' do
    it 'can find one merchant matching a name search' do
      create(:merchant, name: "JUNK n' STUFF")
      create(:merchant, name: 'junk yard')
      merchant3 = create(:merchant, name: 'Merchandise')

      get '/api/v1/merchants/find?name=jun'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json.count).to eq(1)

      merchant = json[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)
      expect(merchant[:id]).to_not eq(merchant3.id)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end

    it 'will return a 204 if there are no name matches' do
      create(:merchant, name: "JUNK n' STUFF")
      create(:merchant, name: 'junk yard')
      create(:merchant, name: 'Merchandise')

      get '/api/v1/merchants/find?name=xyz'

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find one merchant matching a created_at date search' do
      create(:merchant, created_at: Date.today)
      create(:merchant, created_at: Date.today)
      merchant3 = create(:merchant, created_at: 10.days.ago)

      get "/api/v1/merchants/find?created_at=#{Date.today}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json.count).to eq(1)

      merchant = json[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)
      expect(merchant[:id]).to_not eq(merchant3.id)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end

    it 'will return a 204 if there are no created_at matches' do
      create(:merchant, created_at: Date.today)
      create(:merchant, created_at: Date.today)
      create(:merchant, created_at: 10.days.ago)

      get "/api/v1/merchants/find?created_at=#{5.days.ago}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    it 'can find one merchant matching a updated_at date search' do
      create(:merchant, updated_at: Date.today)
      create(:merchant, updated_at: Date.today)
      merchant3 = create(:merchant, updated_at: 10.days.ago)

      get "/api/v1/merchants/find?updated_at=#{Date.today}"

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(json.count).to eq(1)

      merchant = json[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)
      expect(merchant[:id]).to_not eq(merchant3.id)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end

    it 'will return a 204 if there are updated_at matches' do
      create(:merchant, updated_at: Date.today)
      create(:merchant, updated_at: Date.today)
      create(:merchant, updated_at: 10.days.ago)

      get "/api/v1/merchants/find?updated_at=#{5.days.ago}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
    end
  end
end
