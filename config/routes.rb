DonorsChooseWireframe::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"

  resources :projects do
    resources :messages
    resources :challenges do
      resources :challenge_evidences
    end
  end

  match '/auth/:provider/callback', to: 'sessions#create'
  delete 'sessions/destroy'

  root to: 'projects#new'
end
