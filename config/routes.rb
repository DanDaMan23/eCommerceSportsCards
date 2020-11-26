Rails.application.routes.draw do
  root to: 'posts#index'
  # get 'posts/show'

  resources "posts", only: %i[index show]
  resources "cards", only: %i[index show]

  get 'new_cards', to: 'cards#new_cards', as: "new_cards"
  get 'updated_cards', to: 'cards#updated_cards', as: "updated_cards"


  post 'cards/add_to_cart/:id', to: 'cards#add_to_cart', as: "add_to_cart"
  delete 'cards/remove_from_cart/:id', to: 'cards#remove_from_cart', as: "remove_from_cart"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
