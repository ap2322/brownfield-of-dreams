class Users::ActivationController < ApplicationController

  def update
    user = User.find(params[:id])
    user.toggle!(:active?)

    redirect_to "/users/#{user.id}/activation/activated"
  end

  def show
  end

  def new
    user = User.find(params[:id])
    ActivationMailer.activation(user).deliver_now

    redirect_to '/dashboard'
  end

end
