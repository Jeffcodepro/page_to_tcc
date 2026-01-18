Rails.application.routes.draw do
  get 'relatorios/index'
  get 'configuracoes/index'
  get 'financeiros/index'
  devise_for :users


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  devise_scope :user do
    authenticated :user do
      root to: "pages#home", as: :authenticated_root
    end

    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  get "/financeiro", to: "financeiros#index", as: :financeiro
  get "/configuracoes", to: "configuracoes#index", as: :configuracoes
  get "relatorios", to: "relatorios#index", as: :relatorios
end
