# app/controllers/sales_controller.rb
class Admin::SalesController < ApplicationController
  before_action :set_sale, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /sales
  def index
    @sales = Sale.includes(:employee, :products).all
  end

  # GET /sales/1
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    @sale.product_sales.build
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      redirect_to [ :admin, @sale ], notice: "Venta creada exitosamente."
    else
      render :new
    end
  end

  # GET /sales/1/edit
  def edit
    @products = Product.all
  end

  # PATCH/PUT /sales/1
  def update
    if @sale.update(sale_params)
      redirect_to @sale, notice: "Venta actualizada exitosamente."
    else
      @products = Product.all
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /sales/1
  def destroy
    @sale.destroy
    redirect_to sales_url, notice: "Venta eliminada exitosamente."
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(
      :realization_date,
      :customer_dni,
      :customer_name,
      :employee_id,
      product_sales_attributes: [ :id, :product_id, :amount_sold, :total_amount, :_destroy ]
    )
  end
end
