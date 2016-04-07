class Api::CommentsController < ApplicationController
  load_and_authorize_resource :task
  load_and_authorize_resource :comment, :through => :task, :shallow => true

  def create
    @comment.save
    render :show
  end

  def update
    @comment.update(comment_params)
    render nothing: true
  end

  def destroy
    @comment.destroy
    render nothing: true
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :attaches_attributes => [:id, :file])
  end
end