class HomeController < ApplicationController
  # def index
  #   @products = Product.all
  #   @products = @products.where.not("products.name LIKE ?", "*%")

  #   if @products.empty?
  #     @message = "No hay productos disponibles"
  #   else
  #     if params[:categories].present?
  #       @products = @products.joins(:categories).where(categories: { id: params[:categories] })
  #     end

  #     if @products.empty?
  #       @message = "No se encontraron productos para la categoría seleccionada"
  #     end
  #   end

  #   @q = @products.ransack(params[:q])

  #   @products = @q.result(distinct: true)

  #   # Paginación
  #   # @products = @products.page(params[:page]).per(10)

  #   @categories_with_counts = Category.all.map do |category|
  #     {
  #       category: category,
  #       count: category.products.where.not("products.name LIKE ?", "*%").count
  #     }
  #   end
  # end

  def index
    # Configura Ransack para la búsqueda
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
                  .where.not("products.name LIKE ?", "*%")

    # Filtrado por categorías (si está presente)
    if params[:categories].present?
      @products = @products.joins(:categories)
                           .where(categories: { id: params[:categories] })
    end

    # Mensaje cuando no hay productos
    @message = if @products.empty?
                 params[:q].present? ? "No se encontraron productos" : "No hay productos disponibles"
    end

    # Conteo de productos por categoría
    @categories_with_counts = Category.all.map do |category|
      {
        category: category,
        count: category.products.where.not("products.name LIKE ?", "*%").count
      }
    end
  end
end
