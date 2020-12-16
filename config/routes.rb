Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :merchants do
        # resources :items, only: [:index]
        get '/items', to: 'merchants/items#index'
      end
      resources :items do
        resources :merchants, only: [:index]
      end
    end
  end
end
