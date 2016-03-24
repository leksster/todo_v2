class Api::ProjectsController < ApplicationController

  def index
    render json: Project.all, include: :tasks
  end

  def show
    render json: set_project
  end

  def create
    project = Project.create!(project_params)
    render json: project, include: :tasks
  end

  def update
    set_project.update(project_params)
    render json: set_project
  end

  def destroy
    set_project.destroy
    render json: set_project
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit('name')
  end
end
