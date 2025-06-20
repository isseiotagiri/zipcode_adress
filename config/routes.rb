Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "zipcodes#index"
  
  resources :zipcodes, only: [:index] do
    collection do
      get 'search'
      post 'send_sms'
      post 'send_fax'
    end
  end
end
