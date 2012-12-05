SpeechHacker::Application.routes.draw do
  root :to => "meetings#index"
  resources :meetings
  resources :attendances, :only => [:create, :update]
  devise_for :users
  resources :meeting_roles
  resources :users do
  	resources :manuals
  end
  resources :speeches, :only => [:index]
  resources :projects, :only => [:index]

  get "/manuals/:id/projects" => "projects#projects_by_manual"
  
  post '/users/:id/make_admin' => 'users#make_admin', :as => 'make_admin_user'
end
