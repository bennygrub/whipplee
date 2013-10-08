class FavoritesController < ApplicationController
  def create
  	@favorite = current_user.favorites.new(params[:favorite])
  	@post = Post.find(@favorite.post_id)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to root_path, notice: 'Should have gone to JS' }
        format.js
      end
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @post = Post.find(@favorite.post_id)
    @favorite.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Should have gone to JS' }
      format.js
    end
  end
end
