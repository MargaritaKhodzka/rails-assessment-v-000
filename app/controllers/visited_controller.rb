class VisitedController < ApplicationController

  def create
    @visited = Visited.create(destination_id: params[:destination_id], user_id: current_user.id)
    if @visited.save!
      redirect_to root_path
    else
      render root_path
    end
  end

end
