class AdminlController < ApplicationController
  def index
    @users=User.where(:admin => true,:sadmin =>false)
  end

  def show
    @user=User.find(params[:id])
  end
end
