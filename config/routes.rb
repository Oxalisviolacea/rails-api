Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :merchants do
        collection do
          get '/find', to: 'merchants/search#show'
          get '/find_all', to: 'merchants/search#index'
          get '/most_revenue', to: 'merchants#merchant_with_most_revenue'
          get '/most_items', to: 'merchants#merchant_with_most_items_sold'
        end
        get '/items', to: 'merchants/items#index'
      end
      resources :items do
        collection do
          get '/find', to: 'items/search#show'
          get '/find_all', to: 'items/search#index'
        end
        get '/merchants', to: 'items/merchants#index'
      end
    end
  end
end
