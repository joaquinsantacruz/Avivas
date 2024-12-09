class HomeController < ApplicationController
  def index
    @products = Product.all
    @products = @products.where.not("products.name LIKE ?", "*%")

    if @products.empty?
      @message = "No hay productos disponibles"
    else
      if params[:categories].present?
        @products = @products.joins(:categories).where(categories: { id: params[:categories] })
      end

      if @products.empty?
        @message = "No se encontraron productos para la categoría seleccionada"
      end
    end

    @q = @products.ransack(params[:q])

    @products = @q.result(distinct: true)

    # Paginación
    # @products = @products.page(params[:page]).per(10)

    @categories_with_counts = Category.all.map do |category|
      {
        category: category,
        count: category.products.where.not("products.name LIKE ?", "*%").count
      }
    end
  end
end
