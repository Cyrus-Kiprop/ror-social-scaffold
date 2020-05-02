class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @incoming_requests = current_user.incoming_friend_requests
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @incoming_requests = current_user.incoming_friend_requests
  end
end
