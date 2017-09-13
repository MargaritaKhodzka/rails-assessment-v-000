class DestinationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  def index
    @destinations = Destination.all
  end

  def show
    @destination = Destination.find(params[:id])
  end

  def new
    @destination = Destination.new
    @category = @destination.categories.build
  end

  def create
    @destination = Destination.new(destination_params)
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
    @destination.update(destination_params)
    if @destination.save
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
    flash[:notice] = "Destination has been deleted from your bucket list"
    redirect_to user_path(current_user)
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :desription, :visited, category_ids:[], categories_attributes: [:title])
  end

end
