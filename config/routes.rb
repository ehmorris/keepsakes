Journal::Application.routes.draw do
  root :to => 'maps#index', :id => 'map'
end
