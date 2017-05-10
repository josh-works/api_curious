class SessionsController < ApplicationController

  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      session[:id] = user.id
      flash[:notice] = "successfully logged in"
      redirect_to root_path
    else
      flash[:warning] = "unsuccessful login. Please try again."
    end
  end

  def destroy
    session[:id] = nil
    flash[:notice] = "successfully logged out"
    redirect_to root_path
  end

end
