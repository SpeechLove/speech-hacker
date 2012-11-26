SpeechHacker::Application.routes.draw do
  root :to => "meetings#index"
  resources :meetings
  devise_for :users
end
