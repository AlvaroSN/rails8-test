class LikesController < ApplicationController

  #skip_before_action :verify_authenticity_token, :only => [:create, :destroy, :index]
  before_action :authenticate_user!

  def create
    like = current_user.likes.build(params.permit(:product_id))
    if like.save
      render json: { message: "Like successfully created" }, status: :created
    else
      render json: { error: like.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    like = current_user.likes.find_by(product_id: params[:product_id])
    if like
      like.destroy
      render json: { message: "Like successfully removed" }, status: :ok
    else
      render json: { error: "Like not found" }, status: :not_found
    end
  end

end
