class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    if params[:destination_id]
      @categories = Destination.find(params[:destination_id]).categories
    else
      @categories = Category.all
    end
  end

  def show
    if params[:destination_id]
      @category = Destination.find(params[:destination_id]).categories.find(params[:id])
    else
      @category = Category.find(params[:id])
    end
  end

  def new
    if params[:destination_id] && !Destination.exists?(params[:destination_id])
      redirect_to destinations_path, alert: "Destination not found."
    else
      @category = Category.new(destination_id: params[:destination_id])
    end
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to category_path(@category)
  end

  def update
    @category = Category.find(params[:id])
    @category.update(params.require(:category))
    redirect_to category_path(@category)
  end

  def edit
    if params[:destination_id]
      destination = Destination.find_by(id: params[:destination_id])
      if destination.nil?
        redirect_to destinations_path, alert: "Destination not found."
      else
        @category = destination.categories.find_by(id: params[:id])
        redirect_to destination_categories_path(destination), alert: "Category not found." if @category.nil?
      end
    else
      @category = Category.find(params[:id])
    end
  end

private
  def category_params
    params.require(:category).permit(:title, :destination_id)
  end

end
