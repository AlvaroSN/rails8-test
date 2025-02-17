class HomeController < ApplicationController

  before_action :set_turbo_stream_format, only: [:turbo_products]

  def index
  end

  def products
    @page = params[:page]
    @q = Product.ransack(params[:q])
  end

  def turbo_products
    @q = Product.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?

    @products = @q
      .result()
      .page params[:page]
   
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update('public_products', partial: 'home/productsTable', locals: { products: @products }) }
      format.html { redirect_to action: 'products', page: params[:page] }
      format.json { render json: { :products => @products } }
    end
  end

  def likes
    @products = current_user.liked_products
  end

end
