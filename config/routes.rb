Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :merchants do
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
