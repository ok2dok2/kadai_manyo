class Admin::UsersController < ApplicationController
  before_action :admin_user?
  def index
    @users = User.all
  end

  def new
    
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
  

  private
  def admin_user?
    redirect_to tasks_path unless current_user.admin?
    flash[:alret] = '管理者専用ページです'
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
