class ApplicationController < ActionController::Base


    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery
    before_action :redirect_if_unverified

    def redirect_if_unverified
      return unless signed_in? && !current_user.verified?
  
      redirect_to verify_path, notice: "Please verify your email address"
    end

    protect_from_forgery with: :exception

  # rescue_from CanCan::AccessDenied do |exception|
  #   # redirect_to root_path
  #   flash[:danger] = "Sorry, you are not authorized to access this area!"
  # end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, notice: exception.message }
    
    end
  end

    protected
  
    def configure_permitted_parameters
      added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
      
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end



end
