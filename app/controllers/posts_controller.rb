class PostsController < ApplicationController
  before_filter :check_admin, only: [:new, :edit, :update, :destroy, :create]
  require 'will_paginate/array'
  # GET /posts
  # GET /posts.json
  def index
    if params[:filter].nil?
      @posts = Post.all
      @filter_type = ""
    else
      @posts = Post.tagged_with(params[:filter])
      @filter_type = params[:filter]
    end
    
    @posts = @posts.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @favorite_status = Favorite.where("user_id = ? AND post_id = ?", current_user.id, @post.id) if current_user
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def popular
    #@posts = Post.all
    @posts = Post.joins("LEFT OUTER JOIN Favorites ON favorites.post_id = posts.id 
                     AND posts.created_at >= DATETIME('now', '-7 days')")
                    .group("posts.id").order("COUNT(favorites.id) DESC")
    @filter_type = "Comedy"

    if params[:filter]
      @posts = @posts.tagged_with(params[:filter])
      @filter_type = params[:filter]
    end
    @posts = @posts.paginate(:page => params[:page], :per_page => 20)
  end

  private

  def check_admin
    if current_user
      redirect to posts_path, notice: "Only for Admins" unless current_user.admin  
    else 
      redirect_to posts_path, notice: "Only for Admins"
    end

  end

end
