class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def user_visited
    @destinations = current_user.visited_destinations
  end
end
