class Api::TasksController < ApplicationController
  load_and_authorize_resource :project
  load_and_authorize_resource :task, :through => :project, shallow: true

  def create
    @task.save
    p @task.deadline
    render :show
  end

  def update
    @task.update(task_params)
    render nothing: true
  end

  def destroy
    @task.destroy
    render nothing: true
  end

  private

  def task_params
    params.require(:task).permit(:text, :deadline, :priority, :done)
  end
end