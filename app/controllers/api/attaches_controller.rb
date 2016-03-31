class Api::AttachesController < ApplicationController

  # def create
  #   attach = Attach.new(attach_params)
  #   attach.save
  #   render json: attach
  # end

  # def destroy
  #   set_comment.destroy
  #   render nothing: true, status: 204
  # end

  private
  def attach_params
    params.permit(:file, :comment_id)
  end
end