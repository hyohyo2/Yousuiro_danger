# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  
  def admin_authentication
    if params[:email] == ENV['ADMIN_EMAIL'] && params[:password] == ENV['ADMIN_PASSWORD']
      redirect_to "admin_root"
    else
      flash[:alert]="Eメールもしくはパスワードが違います"
      redirect_to admin_session_path
    end
  end
  
  def admin_sign_in_path_for(resource)
    admin_root_path
  end
  
  def after_sign_out_path_for(resource) #管理者のログアウト後の遷移先
    new_admin_session_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  
  
end
