class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def index
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    render 'show_follow'
  end
end
