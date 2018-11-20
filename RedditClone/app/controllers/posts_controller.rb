class PostsController < ApplicationController
  
  before_action :require_login
  
  def new
    @post = Post.new
    render :new
  end
  
  def create
    @post = Post.new(post_params)
    
    if @post.save
      redirect_to post_url(@post)
    else 
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    
    if @post
      if @post.author == current_user
        render :edit
      else
        flash[:errors] = ["Only the author may edit the post"]
        redirect_to post_url(@post)
      end
    else
      flash.now[:errors] = ["Invalid Post ID"]
      render :edit
    end
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
    if @post
      if @post.author == current_user
        @post.destroy
        redirect_to sub_url(@post.sub)
      else
        flash[:errors] = @post.errors.full_messages
        redirect_to post_url(@post)
      end
    else
      flash.now[:errors] = ["Invalid Post ID"]
      redirect_to subs_url
    end
  end
  
  def show
    @post = Post.find(params[:id])
    render :show
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end