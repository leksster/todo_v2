class Api::ProjectsController < ApplicationController
  before_action :authenticate_user_from_token!
  load_and_authorize_resource

  def index
  end

  def show
  end

  def create
    # current_user.projects << @project
    @project.save
    render :show
  end

  def update
    @project.update(project_params)
    render :show
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
