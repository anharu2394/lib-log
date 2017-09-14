Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"}
  devise_scope :user do
 post 'users/sign_up/confirm' => 'users/registrations#confirm'
 post 'users/sign_up/complete' => 'users/registrations#complete'
end
   resources :users, only: [:show]
  resources :user_details, only: [:new,:create,:edit,:update]

  resources :books, only: [:index,:show,:new,:create] do
    collection do
      get 'search'
      get 'ranking'
    end
    resources :reviews
  end

  # get 'books/search' => 'books#search'
root to:'books#index'

end
