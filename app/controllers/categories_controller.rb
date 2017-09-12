class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def show
    @category = Category.find(params[:id])
  end

  def new
    if params[:destination_id] && !Destination.exists?(params[:destination_id])
      redirect_to destinations_path, alert: "Destination not found."
    else
      @category = Category.new(destination_id: params[:destination_id])
    end
  end

  def create
    @destination = Destination.find(params[:destination_id])
    @destination.categories.build(categories_params)
    if @destination.save
      redirect_to destination_path(@destination), notice: "Category has been saved."
    else
      redirect_to destination_path(@destination), alert: "Category has not been saved."
    end
  end


  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to user_path(current_user), notice: "Category has been deleted."
  end

  private

  def categories_params
    params.require(:category).permit(:title, :destination_id)
  end

end
