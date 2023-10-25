Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :tasks do
        get 'task/:id', to: 'tasks#get_task'
        get 'created_tasks', to: 'tasks#created_tasks'
        get 'assigned_tasks', to: 'tasks#assigned_tasks'
        post 'create_task', to: 'tasks#create'
        patch 'task/:id' , to: 'tasks#update'
        delete 'task/:id', to: 'tasks#delete'
      end
    end
  end
end
