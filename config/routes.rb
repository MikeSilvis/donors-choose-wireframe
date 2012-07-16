DonorsChooseWireframe::Application.routes.draw do
  resources :projects do
    resources :messages
    resources :challenges do
      resources :challenge_evidences
    end
  end

  root to: 'projects#new'
end
