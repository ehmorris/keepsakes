Journal::Application.routes.draw do
  root :to => 'maps#index', :id => 'map'

  match '/auth/moves/callback/:code' => 'moves#callback'
  match '/moves/logout' => 'moves#destroy'
end
