class HomeController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
                  .where.not("products.name LIKE ?", "*%")

    if params[:categories].present?
      @products = @products.joins(:categories)
                           .where(categories: { id: params[:categories] })
    end

    @message = if @products.empty?
                 params[:q].present? ? "No se encontraron productos" : "No hay productos disponibles"
    end

    @categories_with_counts = Category.all.map do |category|
      {
        category: category,
        count: category.products.where.not("products.name LIKE ?", "*%").count
      }
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
