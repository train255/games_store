class Admin::ApplicationController < ActionController::Base
  layout "admin"
  
  include Devise::Controllers::Helpers
  before_filter do |controller|
    if controller.env['PATH_INFO'].index("/admin") == 0
      if user_signed_in? || controller.class == Devise::SessionsController
        if (user_signed_in? && !current_user.admin?)
          sign_out current_user
          redirect_to new_user_session_path, notice: "You are not authorize to access this page!"
        end      
      else
        redirect_to new_user_session_path
      end
    end
  end
  
end
