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

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    if @category.save
      flash[:success] = "Your category was updated!"
      redirect_to category_path(@category)
    else
      flash[:error] = "Sorry, this category name already exists!"
      redirect_to edit_category_path(@category)
    end
  end

  def destroy
    category = Category.find(params[:id])
    title = category.title
    category.destroy
    flash[:success] = "Category \"#{title}\" has been deleted."
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
