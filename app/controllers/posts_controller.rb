# coding: utf-8

class PostsController < ApplicationController

  before_filter :authenticate_user!

  # GET /posts
  # GET /posts.json
  # attr_accessible :name, :content, :title, :q
  
  def index
    @search_form = SearchForm.new params[:search_form]
    @posts = Post.scoped(:order => "created_at DESC", :limit => 3).page(params[:page]).per(5)

    if @search_form.q.present?
       @posts= @posts.where(["title LIKE ? or content LIKE ?", "%#{@search_form.q}%", "%#{@search_form.q}%"])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Post.find(params[:id]).comments.build
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to posts_path, notice: '作成されました！'
    else
      render action: 'new'
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to posts_path, notice: '更新されました！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: { post: @post }
  end

def year
    @posts = Post.all(:order => "created_at DESC")
    @post_years = @posts.group_by { |t| t.created_at.beginning_of_year }
  end

  def month
    @posts = Post.all(:order => "created_at DESC")
    @post_months = @posts.group_by { |t| t.created_at.beginning_of_month }
  end

  def day
    @posts = Post.all(:order => "created_at DESC")
    @post_days = @posts.group_by { |t| t.created_at.beginning_of_day }
  end





end
