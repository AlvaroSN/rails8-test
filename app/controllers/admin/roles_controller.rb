class Admin::RolesController < ApplicationController
  layout 'admin'

  before_action :set_role, only: %i[show edit update destroy]
  before_action :set_turbo_stream_format, only: [:turbo_list]

  def index
    @roles = Role.page(params[:page]).per(10)
  end

  def turbo_list
    @q = Role.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?

    @roles = @q.result.page(params[:page])

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update('roles_table', partial: 'admin/roles/table', locals: { roles: @roles }) }
      format.html { redirect_to action: 'index', page: params[:page] }
      format.json { render json: { roles: @roles } }
    end
  end

  def show; end

  def new
    @role = Role.new
  end

  def edit; end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to admin_role_path(@role), notice: 'Role created successfully'
    else
      render :new
    end
  end

  def update
    if @role.update(role_params)
      redirect_to admin_role_path(@role), notice: 'Role updated successfully'
    else
      render :edit
    end
  end

  def destroy
    begin
      @role.destroy
      redirect_to admin_roles_path, notice: 'Role deleted successfully'
    rescue Exception => ex
      Rails.logger.error ex.message
      Rails.logger.error ex.backtrace.join("\n")
      redirect_to admin_roles_path, alert: 'Role cannot be deleted'
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name)
  end
end