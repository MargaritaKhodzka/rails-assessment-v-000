class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_destination, only: %i[index new create]
  before_action :current_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @categories }
    end
  end

  def new
    @category = @destination.categories.build
  end

  def create
    @category = Category.new(category_params)
    @category.destination_ids = params[:destination_id]
    if @category.save
      render json: @category, status: 201
    else
      render :new
    end
  end

  def show
    @destinations = @category.destinations
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @category }
    end
  end

  def edit

  end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end


  def destroy
    title = @category.title
    if @category.delete
      redirect_to categories_path, notice: "#{title} deleted successfully."
    else
      render :show
    end
  end

  private

  def category_params
    params.require(:category).permit(:title, :climate, :must_have_items)
  end

  def find_destination
    @destination = Destination.find_by(id: params[:destination_id])
  end

  def current_category
    @category = Category.find_by(id: params[:id])
  end

end
