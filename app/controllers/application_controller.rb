class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

	rescue_from CanCan::AccessDenied do |exception|
  		redirect_to '/', :alert => exception.message
	end

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:surname,:citta,:roles_mask,:indirizzo])
    end
  def setted_paramaters?(user)
    if (user.long==nil && user.lat==nil) then return true
    else return false
    end
  end