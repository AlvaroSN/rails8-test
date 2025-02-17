class Admin::ProductsController < AdminController
  layout 'admin'

  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_product, only: %i[show edit update destroy]
  before_action :set_turbo_stream_format, only: [:turbo_list]

  def index
    @products = Product.page(params[:page]).per(10)
  end

  def turbo_list
    @q = Product.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?

    @products = @q.result.page(params[:page])

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update('products_table', partial: 'admin/products/table', locals: { products: @products }) }
      format.html { redirect_to action: 'index', page: params[:page] }
      format.json { render json: { products: @products } }
    end
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: 'Product created successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: 'Product updated successfully'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'Product deleted successfully'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image_url)
  end

  def authorize_admin!
    unless current_user.role.name == 'admin'
      redirect_to root_path, alert: 'Acceso denegado.'
    end
  end
end