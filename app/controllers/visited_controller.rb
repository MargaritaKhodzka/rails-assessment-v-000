class VisitedController < ApplicationController

  def create
    @visit = Visit.create(destination_id: params[:destination_id], user_id: current_user.id)
    if @visit.save
      respond_to do |format|
        format.html
        format.json{ render :json }
      end
    end
  end

end
