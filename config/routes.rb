DonorsChooseWireframe::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"

  resources :projects do
    resources :messages
    resources :challenges
  end

  root to: 'projects#new'
end
