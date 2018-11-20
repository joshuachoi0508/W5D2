class SubsController < ApplicationController
  
  def new
    require_login
    @sub = Sub.new
    render :new
  end
  
  def create
    @sub = Sub.new(sub_params)
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def edit
    require_login
    @sub = Sub.find(params[:id])
    
    if current_user == @sub.moderator
      render :edit
    else
      flash[:errors] = ["Must be moderator to edit"]
      redirect_to sub_url(@sub)
    end 
  end
  
  def update
    @sub = Sub.find(params[:id])
    
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else  
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  def index
    @subs = Sub.all
  end
  
  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end