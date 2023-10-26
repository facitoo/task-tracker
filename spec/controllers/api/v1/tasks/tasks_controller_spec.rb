require 'rails_helper'

RSpec.describe Api::V1::Tasks::TasksController, type: :controller do
  
  before :all do
      @current_user = User.create(first_name: 'test' , last_name: 'user', email: 'test@gmail.com') 
      @status = Status.create(label: 'New')
      @task = Task.create(title: 'First Task',description: 'Description of the task',status_id: @status.id,requester_id: @current_user.id)
      @token = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxfQ.kV7SfekBOtpQiZA93xbWEDU30wv47zEzsItVfo2-Oo0'
  end


  describe 'POST #create' do 
    it 'creates a new task' do
      params = {
        title: 'New Task',
        description: 'Description of the task'
      }
      request.headers['Authorization'] = @token
      post :create, params: params
      expect(response).to have_http_status(:created)
    end

    it 'returns unprocessable_entity for invalid data' do
        task_attributes = {
            heading: 'New Task',
            desc: 'Description of the task'
          }
          request.headers['Authorization'] = @token
          post :create, params: task_attributes
          expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #created_tasks' do
    it 'returns a list of tasks created by the user' do
      request.headers['Authorization'] = @token
      get :created_tasks
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #assigned_tasks' do
    it 'returns a list of tasks assigned to the user' do
      request.headers['Authorization'] = @token
      get :assigned_tasks
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #get_task' do
    it 'returns a specific task' do
      request.headers['Authorization'] = @token
      get :get_task, params: { id: @task.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    it 'updates a task' do
      task = Task.find(@task.id)
      request.headers['Authorization'] = @token
      patch :update, params: { id: task.id, title: 'Updated Task' }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['title']).to eq('Updated Task')
    end

    it 'returns unprocessable_entity for invalid data' do
      task = Task.find(@task.id)
      request.headers['Authorization'] = @token
      patch :update, params: { id: task.id, title: ''}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #delete' do
    it 'deletes a task' do
      task = Task.create(title: 'Task to delete',description: 'Description of the task',status_id: @status.id,requester_id: @current_user.id)
      request.headers['Authorization'] = @token
      delete :delete, params: { id: task.id }
      expect(response).to have_http_status(:success)
    end
    it 'throws error if task is not present' do
      request.headers['Authorization'] = @token
      delete :delete, params: { id: 100000 }
      expect(response).to have_http_status(404)
    end
    it 'throws unauthrosied error if you are not the requestor of the task' do 
      new_user = User.create(first_name: 'new' , last_name: 'user', email: 'new@gmail.com')
      new_task = Task.create(title: 'User 2 task',description: 'Description of the task',status_id: @status.id,requester_id: new_user.id)
      request.headers['Authorization'] = @token
      delete :delete, params: { id: new_task.id }
      expect(response).to have_http_status(401)
    end
  end
end