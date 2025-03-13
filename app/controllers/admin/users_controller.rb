class Admin::UsersController < AdminController

  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_turbo_stream_format, only: [:turbo_list]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def turbo_list
    @q = User.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?

    @users = @q
      .result
      .page(params[:page])
   
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update('users_table', partial: 'admin/users/table', locals: { users: @users }) }
      format.html { redirect_to action: 'index', page: params[:page] }
      format.json { render json: { users: @users } }
    end
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: 'User created successfully'
    else
      render :new
    end
  end

  def update
    own_edit = @user == current_user
    if @user.update(user_params)
      unless own_edit
        redirect_to admin_user_path(@user), notice: 'User updated successfully'
      else
        redirect_to root_path, notice: 'User updated successfully'
      end
    else
      render :edit
    end
  end

  def destroy
    begin
      @user.destroy
      redirect_to admin_users_path, notice: 'User deleted successfully'
    rescue Exception => ex
      Rails.logger.error ex.message
      Rails.logger.error ex.backtrace.join("\n")
      redirect_to admin_users_path, alert: 'User cannot be deleted'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar, role_ids: [])
  end

end
