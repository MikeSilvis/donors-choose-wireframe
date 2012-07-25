DonorsChooseWireframe::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque"

  resources :projects do
    resources :messages
    resources :challenges, except: :index do
      resources :challenge_evidences
    end
  end

  match '/auth/:provider/callback', to: 'sessions#create'
  match "/projects/:id/challenges" => redirect("/projects/%{id}/challenges/new")
  delete 'sessions/destroy'

  root to: 'projects#new'
end
