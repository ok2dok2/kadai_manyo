class Admin::UsersController < ApplicationController
  before_action :admin_user?
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to admin_users_path, notice: 'ユーザーを作成しました'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
      redirect_to admin_users_path, notice: '削除しました'
  end
  

  private
  def admin_user?
    redirect_to tasks_path unless current_user.admin?
    flash[:alret] = '管理者専用ページです'
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
  end
end

# def ##管理者権限付与
#   @user = User.find(params[:id])
#   @user.admin = true
#   @user.save
# end
