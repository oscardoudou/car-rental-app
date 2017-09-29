class AdminlController < ApplicationController
  def index
    @users=User.where(:admin => true,:sadmin =>false)

  end
end
