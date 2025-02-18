require 'csv'

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
    .with_attached_image
    .page params[:page]
   
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update('all_products', partial: 'home/productsTable', locals: { products: @products, cols: 3 }) }
      format.html { redirect_to action: 'products', page: params[:page] }
      format.json { render json: { products: @products } }
    end
  end

  def download_csv
    api = TestApi.new("get", "get_users", {})
    response = api.do_request
    if response.nil?
      render plain: "Error al obtener datos de la API", status: :internal_server_error
      return
    end

    users = response["data"] || []
    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["User ID", "User Email", "Product ID", "Product Name"]
      users.each do |user|
        user_likes = user["likes"] || []
        user_likes.each do |like|
          product = like["product"]
          csv << [user["id"], user["email"], product["id"], product["name"]]
        end
      end
    end
    send_data csv_data, filename: "users_with_products.csv", type: "text/csv"
  end

end
