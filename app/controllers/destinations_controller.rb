class DestinationsController < ApplicationController
  before_action :authenticate_user!
  before_action :all_categories, only: %i[new create edit update show]
  before_action :current_destination, only: %i[show edit update destroy]

  def index
    @destinations = Destination.all.order('created_at ASC')
    respond_to do |format|
      format.html
      format.json { render json: @destinations }
    end
  end

  def new
    @destination = Destination.new
    @categories = Array.new { @destination.categories.build }
  end

  def create
    @destination = Destination.new(destination_params)
    @destination = current_user.destinations.build(destination_params)
    if @destination.save
      redirect_to destination_path(@destination), notice: 'A new destination has been created'
    else
      render :new
    end
  end

  def show
    @destination = Destination.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @destination }
    end
  end

  def edit

  end

  def update
    if @destination.update(destination_params)
      redirect_to @destination, notice: 'Your destination has been successfully updated'
    else
      render :edit
    end
  end

  def visited(_user)
    @visits << Visited.new(user: @user)
  end

  def notvisited(_user)
    @visits.where(user_id: @user.id).first.destroy
  end

  def destroy
    @destination.destroy
    redirect_to root_path, notice: 'You have deleted this destination'
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :description, :country, :best_season_to_visit, :visited, :user_id, category_ids:[], categories_attributes: %i[title climate must_have_items])
  end

  def all_categories
    @categories = current_user.categories
  end

  def current_destination
    @destination = Destination.find_by(id: params[:id])
  end

end
