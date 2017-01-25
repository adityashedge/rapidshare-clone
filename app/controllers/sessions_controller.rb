class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Signed in successfully."
      redirect_to root_path
    else
      flash[:error] = "Incorrect email/password."
      render :new
    end
  end

  def destroy 
    session[:user_id] = nil
    redirect_to new_session_path, notice: "Signed out successfully."
  end
end