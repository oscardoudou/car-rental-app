class AdminlController < ApplicationController
  def index
    @users=User.all
  end
end
