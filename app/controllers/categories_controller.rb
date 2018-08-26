class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category)
    else
      flash[:error] = "Sorry, this category name already exists!"
      redirect_to new_category_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def updated
    @category = Category.find(params[:id])
    if @category.save
      flash[:success] = "Your category was updated!"
      redirect_to category_path(@category)
    else
      flash[:error] = "Sorry, this category name already exists!"
      redirect_to edit_category_path(@category)
    end
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
