Rails.application.routes.draw do
  devise_for :users
  resources :projects do
    member do
      get :tasks
      post :task_attach
      post :task_remove
      post :task_add
    end
  end
  resources :tasks
  root 'projects#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
