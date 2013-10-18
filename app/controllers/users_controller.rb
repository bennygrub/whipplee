class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @favorites = @user.favorites.order("created_at DESC")
    @my_favorite_posts = @favorites.map {|favorite| Post.find(favorite.post_id)}
  end

  def index
    @search = User.search(params[:search])
    if current_user.admin == true
      @users = @search.all
    end
    if params[:search]      
      @users = @search.all
    end

  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @following = @user.following
    #render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @followers = @user.followers
    #render 'show_follow'
  end

  def feed
    @title = "You and Your Friends Favorites"
    @user = User.find(params[:id])
    @following = @user.following
    @autofollowers = @user.following_ids
    @following_ids = @following.map {|follow| follow.id }
    @friends_favorites = Favorite.where("user_id IN (?)", @following_ids)
    @friends_favorite_posts = @friends_favorites.map {|favorite| Post.find(favorite.post_id)}
    @my_favorite_posts = @user.favorites.map {|favorite| Post.find(favorite.post_id)}
  end

end
