class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create]

  def show
    if params[:destination_id]
      @destination = Destination.find_by(id: params[:destination_id])
      @category = @destination.categories.find_by(id: params[:id])
      if @category.nil?
        flash[:alert] = "Category not found."
        redirect_to destination_categories_path(@destination)
      end
    else
      @category = Category.find(params[:id])
    end
  end

  def new
    @category = Category.new
    redirect_to categories_path
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Category has been deleted."
    redirect_to user_path(current_user)
  end

  private

  def categories_params
    params.require(:category).permit(:title, :destination_name)
  end

end
