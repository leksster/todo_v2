class Api::TasksController < ApplicationController

  def index
    render json: set_project.tasks
  end

  def show

  end

  def create
    task = Task.create!(task_params)
    render json: task
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
    params.require(:task).permit(:text, :deadline, :priority, :project_id)
  end
end