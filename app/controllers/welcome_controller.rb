class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: [:visited]

  def home
  end

  def visited
    @visited = current_user.visited_destinations
  end

end
