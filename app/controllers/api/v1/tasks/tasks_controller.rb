class  Api::V1::Tasks::TasksController < ApplicationController
  before_action :set_task, except: [:created_tasks, :assigned_tasks , :create]
	DEFAULT_STATUS_LABEL = "New"

  def created_tasks
    tasks = @current_user.created_tasks
    render json: tasks
  end

  def assigned_tasks
    tasks = @current_user.assigned_tasks
    render json: tasks
  end

  def get_task
    render json: @task
  end

  def create
    status_id = Status.find_by(label: DEFAULT_STATUS_LABEL).id
    params = task_params
    task = Task.new(title: params['title'],description: params['description'], requester_id: @current_user.id, status_id: status_id)
    begin
      task.save!
      render json: task, status: :created
    rescue => e
      render json: {"message": e.message}, status: :unprocessable_entity
    end
  end

  def update
    begin
      @task.update!(task_params)
      render json: @task
    rescue => e
      render json: {"message": e.message}, status: :unprocessable_entity
    end
  end

  def delete
    task_owner = @task.requester
    begin
      if task_owner.id == @current_user.id
        @task.destroy!
        render json: {"message": "item removed successfully"}, status: (201)
      else
        render json: {"message": "you cannot delete the given task, please ask the requester to perform this action"}, status: (401)
      end
    rescue => e
      render json: {"message": e.message}, status: :unprocessable_entity
    end
  end

  private 

  def set_task
    @task = Task.find_by(id: params[:id])
    render json: {"message": "not found"}, status: (404) if @task.nil?
  end
  
  def task_params
    params.permit(:title, :description, :assignee_id)
  end
  
end