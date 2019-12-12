class FriendshipsController < ApplicationController
  def create
    friendship = current_user.friendships.new(friend_id: params[:friend_id])
    if friendship.validate_friend && followering?(params[:friend_id]) && friendship.save
      flash[:success] = 'Friend added!'
    else
      flash[:error] = 'Unable to add friend'
    end
    redirect_to '/dashboard'
  end

  def followering?(friend_id)
    user = User.find(friend_id)
    GithubUser.all.match?(user.username)
  end
end
