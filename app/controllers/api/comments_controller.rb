class Api::CommentsController < ApplicationController

  def index
    render json: set_task.comments
  end

  def show
  end

  def create
    comment = Comment.create!(comment_params)
    render json: comment, include: :attaches
  end

  def update
    set_comment.update(comment_params)
    render nothing: true, status: 204
  end

  def destroy
    set_comment.destroy
    render nothing: true, status: 204
  end


  private
  def set_task
    @task = set_project.tasks.find(params[:task_id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_comment
    @comment = set_task.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text, :task_id, :attaches_attributes => [:id, :file])
  end
end