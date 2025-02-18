class AdminController < ApplicationController
  include TurboStreamFormat
  layout 'admin'

  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    
  end

  def authorize_admin
    redirect_to(root_path, alert: "Sorry, you don't have permission for this") unless current_user&.admin?
  end
  
end