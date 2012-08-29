class StaticPagesController < ApplicationController
  def help
  end

  def about
  end

  def contact
  end
  
  def link_download
    @device = params[:device]
    @game = Game.find(params[:gameid])
  end
  
end
