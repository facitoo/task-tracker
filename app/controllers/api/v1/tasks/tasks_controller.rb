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
    task = Task.new(title: params['title'],description: params['description'], requester_id: @current_user.id, status_id: status_id)
    if task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def delete
    @task.destroy
    render status: 200
  end

  private 

  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.permit(:title, :description, :assignee_id)
  end
  
end