module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin

    def index
      # Código para la acción index
    end

    private

    def authorize_admin
      redirect_to(root_path, alert: "No tienes permiso para acceder a esta página.") unless current_user.role.email == 'admin'
    end
  end
end