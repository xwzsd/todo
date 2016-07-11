Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :todo_lists do
        resources :todo_tasks do 
          member do
        	patch :complete
          end
          resources :todo_comments do
            resources :todo_attachments do
            end
          end
        end
      end
      # root "todo_lists#index"
    end
  end
  root to: 'application#angular'
end
