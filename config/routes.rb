Rails.application.routes.draw do
  resources :movies do
    collection do
      get 'search'
    end
  end
end
