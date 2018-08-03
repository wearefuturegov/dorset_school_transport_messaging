Rails.application.routes.draw do
  resources :routes do
    resources :messages, only: %i[create]
  end
  resources :residents, only: %i[create]
end
