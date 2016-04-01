class Api::TasksController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :task, :through => :project

  def index
    render json: @project.tasks
  end

  def create
    @task.save
    render json: @task, include: :comments
  end

  def update
    @task.update(task_params)
    render nothing: true, status: 204
  end

  def destroy
    @task.destroy
    render nothing: true, status: 204
  end

  private

  def task_params
    params.require(:task).permit(:text, :deadline, :priority, :done, :project_id)
  end
end