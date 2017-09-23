class SadminlController < ApplicationController
  def index
    @users=User.where( :sadmin => true)
  end
end
