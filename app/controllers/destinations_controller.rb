class DestinationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  def index
    @destinations = Destination.all
  end

  def show
    @destination = Destination.find(params[:id])
    @category = @destination.categories.build
  end

  def new
    @destination = Destination.new
    @category = @destination.categories.build
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
      flash[:notice] = "Destination successfully updated."
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Destination not updated."
      render :edit
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    @destination.destroy
    redirect_to user_path(current_user), notice: "Destination has been deleted from your bucket list"
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :description, :visited, :categories_attributes => [:title])
  end

end
