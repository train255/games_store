class Admin::UsersController < ApplicationController
  layout "admin"
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_without_password(params[:user])
      redirect_to [:admin, @user], notice: 'User was successfully updated'
    else
      render action: "edit"
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to [:admin, @user], notice: "User was successfully created."
    else
      render action: "new"
    end
  end
end
