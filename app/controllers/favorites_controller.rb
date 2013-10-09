class FavoritesController < ApplicationController
  def create
  	@favorite = current_user.favorites.new(params[:favorite])
  	@post = Post.find(@favorite.post_id)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to posts_path, notice: "You Favorited: #{@post.title}" }
        format.js
      end
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @post = Post.find(@favorite.post_id)
    @favorite.destroy

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "You UnFavorited: #{@post.title}" }
      format.js
    end
  end
end
