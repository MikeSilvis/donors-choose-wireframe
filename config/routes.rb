DonorsChooseWireframe::Application.routes.draw do
  root to: 'projects#new'
  resources :projects
end
