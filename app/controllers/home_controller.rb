class HomeController < ApplicationController

  skip_before_action :require_login, only: [:index]

  def index
    if current_user.class == OpenStruct
      redirect_to login_path
    else
      redirect_to courses_path
    end
  end

end
