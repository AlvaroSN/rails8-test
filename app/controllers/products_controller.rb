class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:like, :unlike]

  def like
    @product = Product.find(params[:product_id])
    Like.create(user: current_user, product: @product)
    redirect_to @product
  end

  def unlike
    @product = Product.find(params[:product_id])
    Like.find_by(user: current_user, product: @product).destroy
    redirect_to @product
  end

  def likes
    @products = current_user.liked_products
  end
end