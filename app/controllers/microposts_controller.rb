class MicropostController < ApplicationController
  def index
    @microposts = Micropost.all
  end 
  
  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = Micropost.new(params[:micropost])
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
  end
end
