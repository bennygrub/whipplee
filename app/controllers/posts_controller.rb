class PostsController < ApplicationController
  before_filter :check_admin, only: [:new, :edit, :update, :destroy, :create]
  require 'will_paginate/array'
  # GET /posts
  # GET /posts.json
  def index
    if params[:filter].nil?
      @posts = Post.find(:all, :order => 'created_at DESC')
      @filter_type = ""
    else
      @posts = Post.tagged_with(params[:filter]).order('created_at DESC')
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
    @media = [["Video", "video"], ["Image", 'image'], ["Written", 'written'], ["Audio", "audio"]]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @media = [["Video", "video"], ["Image", 'image'], ["Written", 'written'], ["Audio", "audio"]]
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
    @posts = Post.where("created_at >= ?", 2.weeks.ago).order("favorite DESC")
    @filter_type = "Comedy"

    if params[:filter]
      #@last_2weeks = Post.where("created_at >= ?", 5.weeks.ago).limit(20)
      @filter_type = params[:filter]
      @post2 = Post.tagged_with(params[:filter]).order("favorite DESC")
      @posts = @post2.map {|post| post if post.created_at >= 2.weeks.ago}
      #@posts = @posts.map {|post| post if post.filter_list == [@filter_type]}

      #@posts = Post.tagged_with(params[:filter]).order("favorite DESC")
      #@posts = Post.where("created_at >= ?", 5.weeks.ago).order("favorite DESC")
      #@posts_with_tag = @posts.map {|post|  } 
    end
    @posts = @posts.paginate(:page => params[:page], :per_page => 20)
  end

  private

  def check_admin
    if current_user
      redirect_to posts_path, notice: "Only for Admins" unless current_user.admin  
    else 
      redirect_to posts_path, notice: "Only for Admins"
    end

  end

end
