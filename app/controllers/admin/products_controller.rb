class Admin::ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [ :show ]
  load_and_authorize_resource

  # GET /products
  def index
    @products = Product.all
    @products = @products.where.not("name LIKE ?", "*%")
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    # Para seleccionar categorías al crear el producto
    @categories = Category.all
  end

  # POST /products
  def create
    # Filtrar los IDs vacíos del parámetro category_ids
    category_ids = params[:product][:category_ids].reject(&:blank?)

    @product = Product.new(product_params)
    @product.category_ids = category_ids

    if @product.save
      redirect_to [ :admin, @product ], notice: "Producto creado exitosamente."
    else
      @categories = Category.all
      render :new
    end
  end

  # GET /products/1/edit
  def edit
    # Para editar las categorías del producto
    @categories = Category.all
  end

  # PATCH/PUT /products/1
  def update
    # Filtrar los IDs vacíos del parámetro category_ids
    category_ids = params[:product][:category_ids].reject(&:blank?)

    if @product.update(product_params)
      @product.category_ids = category_ids
      redirect_to [ :admin, @product ], notice: "Producto actualizado exitosamente."
    else
      @categories = Category.all
      render :edit
    end
  end

# DELETE /products/1
def destroy
  # Marcar el producto como eliminado lógicamente al anteponer un '*' al nombre
  @product.update(name: "*#{@product.name}")
  @product.update(available_stock: 0)
  @product.update(deleted_date: Time.now)

  # Redirigir al listado de productos con un mensaje de éxito
  redirect_to admin_products_url, notice: "Producto eliminado exitosamente."
end

def delete_image
  @product = Product.find(params[:id])
  image = @product.images.find(params[:image_id])
  image.purge
  redirect_to edit_admin_product_path(@product), notice: "Imagen eliminada exitosamente."
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :unit_price, :available_stock, :size, :color, :entry_date, :deleted_date, images: [], category_ids: [])
    end
end
