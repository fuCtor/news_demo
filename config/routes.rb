Rails.application.routes.draw do
  resource :news, path: 'admin', only: [:show, :create]
  root to: 'news#index'
end
