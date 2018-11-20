class SessionsController < ApplicationController
  
  def new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    
    if @user
      login(@user)
    else
      flash[:errors] = ["Invalid Credentials!"]
      render :new
    end
  end
  
  def destroy
    logout!
    redirect_to new_session_url
  end
  
end