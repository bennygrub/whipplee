class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @favorites = @user.favorites
    @my_favorite_posts = @favorites.map {|favorite| Post.find(favorite.post_id)}
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

  def feed
    @title = "You and Your Friends Favorites"
    @user = User.find(params[:id])
    @following = @user.following
    @following_ids = @following.map {|follow| follow.id }
    @friends_favorites = Favorite.where("user_id IN (?)", @following_ids)
    @friends_favorite_posts = @friends_favorites.map {|favorite| Post.find(favorite.post_id)}
    @my_favorite_posts = @user.favorites.map {|favorite| Post.find(favorite.post_id)}
  end

end
