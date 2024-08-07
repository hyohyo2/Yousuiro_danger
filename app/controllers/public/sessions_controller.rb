# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
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

  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  
  # ログアウト後の遷移先
  def after_sign_out_path_for(resource)
    root_path
  end

  # ゲストログイン機能
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user.id), notice: 'ゲストユーザーでログインしました。'
  end


  private
  # ユーザステータス(退会したらログインできないようにする)
  def user_state
    user = User.find_by(email: params[:user][:email])
    return if user.nil?
    return unless user.valid_password?(params[:user][:password])
    unless user.is_active == true
      redirect_to new_user_registration_path, notice: '退会済みのため、再度新規登録が必要です。'
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end


end
