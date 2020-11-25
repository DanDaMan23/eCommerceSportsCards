Rails.application.routes.draw do
  root to: 'posts#index'
  # get 'posts/show'

  resources "posts", only: %i[index show]
  resources "cards", only: %i[index show]

  get 'new_cards', to: 'cards#new_cards', as: "new_cards"
  get 'updated_cards', to: 'cards#updated_cards', as: "updated_cards"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
