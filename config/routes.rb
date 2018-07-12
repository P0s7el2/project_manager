Rails.application.routes.draw do
  resources :projects do
    member do
      get :tasks
      post :task_add
      post :task_remove
    end
  end
  resources :tasks

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
