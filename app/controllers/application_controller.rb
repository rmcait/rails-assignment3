class ApplicationController < ActionController::Base

  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def new_kara
    @book_new = Book.new
  end

  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  	devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  	#devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :profile_image])
  end

  def after_sign_up_path_for(resource)
  #   super(resource)
  	user_path(resource)
  end

  # The path used after sign up.
  def after_sign_in_path_for(resource)
  #   super(resource)
  # mypage_path(resource)
  	user_path(resource)
  end

  #passwordなしでupdate
  def update_resource(resource, params)
  	resource.update_without_password(params)
  end
end