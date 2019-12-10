class FriendshipsController < ApplicationController
  def create
    friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if friendship.save
      flash[:success] = 'Friend added!'
    else
      flash[:error] = 'Unable to add friend'
    end
    redirect_to '/dashboard'
  end
end
