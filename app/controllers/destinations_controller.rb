class DestinationsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :update, :destroy]

  def index
    @destinations = Destination.all
  end

  def new
    @destination = Destination.new
  end

  def create
    @destination = current_user.destinations.build(destination_params)
    if @destination.save
      flash[:notice] = "You have added a new destination to your bucket list!"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Destination hasn't been saved to your bucket list."
      render :new
    end
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params)
      flash[:notice] = "Destinations is updated!"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Destination hasn't been updated."
      render :edit
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    @destination.destroy
    flash[:notice] = "Destination has been deleted from your bucket list"
    redirect_to user_path(current_user)
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :description, :visited, :categories_attributes => [:title])
  end

end
