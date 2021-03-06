class FriendshipsController < ApplicationController
  def index; end

  def show; end

  def create
    respond_to do |format|
      if Friendship.new.unique_friendship?(current_user, params[:id])
        format.html { redirect_to :users, notice: 'Friend request sent' }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :index }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    user = User.find(params[:id])

    respond_to do |format|
      if current_user.confirm_friend_request?(user)
        format.html { redirect_to posts_path, notice: "#{user.name} is now your friend" }
      else
        format.html { redirect_to posts_path, alert: 'Error in accepting the friend request' }
      end
    end
  end

  def destroy
    request = current_user.friendships.where(friend_id: params[:id]).first || current_user.inverse_friendships.where(user_id: params[:id]).first
    request&.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Request was successfully revoked' }
      format.json { head :no_content }
    end
  end
end
