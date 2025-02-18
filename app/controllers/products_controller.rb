class ProductsController < ApplicationController

  before_action :set_turbo_stream_format, only: [:turbo_products]
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

  def favourites
    
  end

  def turbo_products
    @likes = current_user.liked_products.order(updated_at: :desc).page params[:page] if current_user
   
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update('favourites_products', partial: 'home/productsTable', locals: { products: @likes, cols: 4 }) }
      format.html { redirect_to action: 'favourites', page: params[:page] }
      format.json { render json: { :products => @products } }
    end
  end

end