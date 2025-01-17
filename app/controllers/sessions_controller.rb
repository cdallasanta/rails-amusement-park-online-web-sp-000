class SessionsController < ApplicationController
  def new
    render 'signin'
  end

  def create
    user = User.find(params[:user_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to '/signin'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/'
  end
end
