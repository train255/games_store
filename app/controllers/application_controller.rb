class ApplicationController < ActionController::Base
  
  def after_sign_in_path_for(resource)
    # binding.pry
    if resource.admin?
      admin_games_path
    else
      root_path
    end
  end
end
