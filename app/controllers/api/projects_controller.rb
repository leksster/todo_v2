class Api::ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :project

  def index
  end

  def show
  end

  def create
    @project.user = current_user
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
