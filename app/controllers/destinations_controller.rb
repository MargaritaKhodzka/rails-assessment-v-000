class DestinationsController < ApplicationController
  before_action :authenticate_user!
  before_action :all_categories, only: %i[new create edit update show]
  before_action :current_destination, only: %i[update destroy]

  def index
    @destinations = current_user.destinations
  end

  def new
    @destination = Destination.new(user_id: current_user.id)
    @destination.categories.build
  end

  def create
    @destination = Destination.create(destination_params)
    if @destination.save
      redirect_to @destination
    else
      render :new
    end
  end

  def show
    if current_destination
      @categories = @destination.categories
      @category = Category.new
      respond_to do |f|
        f.html { render :show }
        f.json { render json: @destination }
      end
    else
      redirect_to destinations_path
    end
  end

  def next
    next_destination = current_destination.next
    render json: next_destination
  end

  def edit
    if current_destination
      @destination.categories.build
      render :edit
    else
      redirect_to destinations_path
    end
  end

  def update
    if @destination.update(destination_params)
      redirect_to @destination
    else
      render :edit
    end
  end

  def destroy
    name = @destination.name
    if @destination.delete
      redirect_to destinations_path, notice: "#{name} deleted successfully."
    else
      render :show
    end
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
