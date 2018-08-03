Rails.application.routes.draw do
  resources :routes do
    resources :messages, only: %i[create]
  end
end
