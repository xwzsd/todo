Rails.application.routes.draw do
  root to: 'application#angular'
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      shallow do
        resources :todo_lists, except: [:new, :edit] do
          resources :todo_tasks, except: [:new, :edit] do 
            resources :todo_comments, only: [:index, :create, :destroy] do
              resources :todo_attachments, only: [:create, :destroy]
            end
          end
        end
      end
    end
  end
end
