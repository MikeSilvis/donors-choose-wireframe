DonorsChooseWireframe::Application.routes.draw do
  devise_for :users

  mount Resque::Server.new, :at => "/resque"

  resources :projects do
    resources :messages
    resources :challenges do
      resources :challenge_evidences
    end
  end

  devise_scope :user do
  	get "signin", :to => "devise/sessions#new"
  end

  root to: 'projects#new'
end
