module ApplicationHelper

  def active_if_in_controller?(*controllers)
    is_in_controller = controllers.flatten.map(&:to_s).include? controller_name
    is_in_controller ? 'active' : 'not_active'
  end
  
end
