class UsersController < ApplicationController
  def show
    @user_facade = UserFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      ActivationMailer.activation(@user).deliver_now
      flash[:success] = "Logged in as #{@user.first_name}"
      redirect_to dashboard_path
    else
      flash[:error] = 'Email already registered'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
