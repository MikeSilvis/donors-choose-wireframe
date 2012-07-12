DonorsChooseWireframe::Application.routes.draw do
  resources :projects do
    resources :messages
    resources :challenges
  end

  root to: 'projects#new'
end
