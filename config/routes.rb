Rails.application.routes.draw do
  LOCALES = /en|pt\-BR/

  scope "(:locale)", locale: LOCALES do
    resources :rooms
    resources :users
  end

  get '/:locale' => 'home#index', locale: LOCALES
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
