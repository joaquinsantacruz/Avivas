class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy, :delete_image ]
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
    @categories = Category.all
  end

  # PATCH/PUT /products/1
  def update
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
  @product.logic_delete
  redirect_to admin_products_url, notice: "Producto eliminado exitosamente."
end

def delete_image
    image = @product.images.find(params[:image_id])
  image.purge
  redirect_to edit_admin_product_path(@product), notice: "Imagen eliminada exitosamente."
end


  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :unit_price, :available_stock, :size, :color, :entry_date, :deleted_date, images: [], category_ids: [])
    end
end
