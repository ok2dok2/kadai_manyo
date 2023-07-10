class UsersController < ApplicationController
  def new
    if current_user == nil #これを書くことで１４の条件がかける
      @user = User.new
    else
      redirect_to tasks_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new, notice = "作成できませんでした"
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = current_user.tasks.all
      unless current_user == @user #もし自分じゃない場合はマイページに飛べない
      redirect_to tasks_path,notice: '他ユーザーのマイページにはアクセスできません'
      end
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end


