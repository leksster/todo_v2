class Api::ProjectsController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @projects, include: { tasks: { include: { comments: { include: :attaches} } } }
  end

  def show
    render json: @project
  end

  def create
    current_user.projects << @project
    render json: @project, include: { tasks: { include: { comments: { include: :attaches} } } }
  end

  def update
    @project.update(project_params)
    render json: @project
  end

  def destroy
    @project.destroy
    render nothing: true
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
