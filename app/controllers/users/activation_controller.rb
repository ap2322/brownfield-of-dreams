class Users::ActivationController < ApplicationController

  def update
    user = User.find(params[:id])
    user.toggle(active?)

    redirect_to "/users/#{user.id}/activation/activated"
  end

end
