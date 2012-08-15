class MicropostsController < ApplicationController
  def index
    @microposts = Micropost.all
  end 
  
  def new
    @micropost = Micropost.new
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  def create
    @micropost = Micropost.new(params[:micropost])

    if @micropost.save
      redirect_to microposts_url, notice: 'micropost was successfully created.'
    else
      render action: "new"
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy

    redirect_to microposts_url
  end
end
