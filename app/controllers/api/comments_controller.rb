class Api::CommentsController < ApplicationController
  load_and_authorize_resource :task
  load_and_authorize_resource :through => :task

  def index
    render json: @comments
  end

  def create
    @comment.save
    render json: @comment, include: :attaches
  end

  def update
    @comment.update(comment_params)
    render nothing: true, status: 204
  end

  def destroy
    @comment.destroy
    render nothing: true, status: 204
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :task_id, :attaches_attributes => [:id, :file])
  end
end