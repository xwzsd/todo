Rails.application.routes.draw do
  resources :todo_lists do
    resources :todo_tasks
  end
  
  root "todo_lists#index"
end
