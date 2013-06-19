Journal::Application.routes.draw do
  root :to => 'maps#index'

  match '/auth/moves/callback' => 'moves#callback'
  match '/moves/logout' => 'moves#destroy'
end
