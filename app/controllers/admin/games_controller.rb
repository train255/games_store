class Admin::GamesController < Admin::ApplicationController
  layout "admin"
 
  def index
    # binding.pry
    if params[:search_text].present?
      @games = Game.fulltext_search(params[:search_text], { :max_results => 100 })
    else
      @games = Game.all
    end
    
    @per_page = 5
    if params[:sort_by] == "average_rating"
      if params[:direction] == "asc"
        @games = @games.sort {|a, b| a.average_rating <=> b.average_rating}
      else
        @games = @games.sort {|a, b| b.average_rating <=> a.average_rating}
      end
    elsif params[:sort_by] == "name" || params[:sort_by] == "price"
      if params[:direction] == "asc"
        @games = @games.sort {|a, b| a[params[:sort_by].to_sym].to_s <=> b[params[:sort_by].to_sym].to_s}
      else
        @games = @games.sort {|a, b| b[params[:sort_by].to_sym].to_s <=> a[params[:sort_by].to_sym].to_s}
      end
    else
      @games = @games.sort {|a, b| a[:name].to_s <=> b[:name].to_s}
    end
    
    if @games.is_a? Array
      @games = Kaminari.paginate_array(@games).page(params[:page]).per(@per_page)
    else
      @games = @games.page(params[:page]).per(@per_page)
    end
  end

  def show
    @per_page = 5
    @game = Game.find(params[:id])
    @comments = @game.comments
    @game_images = @game.game_images
  end

  def new
    @game = Game.new
    5.times { @game.game_images.build }
  end

  def edit
    @game = Game.find(params[:id])
    (5 - @game.game_images.count).times { @game.game_images.build }
  end

  def create
    # binding.pry
    @game = Game.new(params[:game])

    if @game.save
      redirect_to [:admin, @game], notice: 'Game was successfully created.'
    else
      render action: "new" 
    end
  end

  def update
    @game = Game.find(params[:id])
    # binding.pry
    if @game.update_attributes(params[:game])
      redirect_to [:admin, @game], notice: 'Game was successfully updated.' 
    else
      render action: "edit" 
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.comments.delete_all
    @game.rates.delete_all
    @game.game_images.delete_all
    @game.destroy
    redirect_to admin_games_url
  end

end
