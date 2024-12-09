class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [ :destroy ]
  # before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def create
    if Category.exists?(name: category_params[:name])
      redirect_to admin_categories_path, alert: "Error: La categoría '#{category_params[:name]}' ya existe."
    else
      @category = Category.new(category_params)
      if @category.save
        redirect_to admin_categories_path, notice: "Categoría creada exitosamente."
      else
        redirect_to admin_categories_path, alert: "Error: La categoría ya existe."
      end
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path, notice: "Categoría eliminada exitosamente."
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
