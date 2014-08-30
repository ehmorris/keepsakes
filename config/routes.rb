Keepsakes::Application.routes.draw do
  root :to => 'users#edit'

  resources :passwords,
    :controller => 'clearance/passwords',
    :only       => [:new, :create]

  resource  :session,
    :controller => 'clearance/sessions',
    :only       => [:create, :destroy]

  resources :users, :controller => 'users' do
    resource :password,
      :controller => 'clearance/passwords',
      :only       => [:create, :edit, :update]
  end

  resources :days,
    :only => [:show]

  match 'account'  => 'users#edit'

  match '/auth/moves/callback' => 'moves#callback'
  match '/moves/logout' => 'moves#destroy'

  match '/auth/instagram/callback' => 'instagram#callback'
  match '/instagram/logout' => 'instagram#destroy'
end
