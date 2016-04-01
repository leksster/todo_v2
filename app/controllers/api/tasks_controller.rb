class Api::TasksController < ApplicationController

  def index
    render json: set_project.tasks
  end

  def show
    render json: set_task
  end

  def create
    task = Task.create!(task_params)
    render json: task, include: :comments
  end

  def update
    set_task.update(task_params)
    render nothing: true, status: 204
  end

  def destroy
    set_task.destroy
    render nothing: true, status: 204
  end

  private
  def set_task
    @task = set_project.tasks.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:text, :deadline, :priority, :done, :project_id)
  end
end