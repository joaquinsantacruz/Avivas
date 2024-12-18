# app/controllers/sales_controller.rb
class Admin::SalesController < ApplicationController
  before_action :set_sale, only: [ :show, :edit, :destroy ]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /sales
  def index
    @sales = Sale.active.includes(:employee, :products)
  end

  # GET /sales/1
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
    @sale.product_sales.build
    @products = Product.active.available
  end

  # POST /sales
  def create
    if session[:product_list].blank?
      redirect_to new_admin_sale_path, alert: "No se han agregado productos a la venta."
      return
    end

    total_amount = session[:product_list].sum do |product|
      product["amount_sold"].to_i * product["sale_price"].to_f
    end

    sale = Sale.new(
      realization_date: params[:sale][:realization_date] || Date.current,
      total_amount: total_amount,
      employee_id: params[:sale][:employee_id],
      customer_dni: params[:sale][:customer_dni],
      customer_name: params[:sale][:customer_name]
    )

    if sale.save
      session[:product_list].each do |product|
        ProductSale.create(
          product_id: product["product_id"],
          sale_id: sale.id,
          amount_sold: product["amount_sold"],
          sale_price: product["sale_price"]
        )

        Product.find(product["product_id"]).remove_stock(product["amount_sold"].to_i)
      end

      session[:product_list] = nil

      redirect_to admin_sales_path, notice: "Venta creada exitosamente."
    else
      redirect_to new_admin_sale_path, alert: "Error al crear la venta. Por favor, verifica los datos ingresados."
    end
  end

  def update_product_list
    product_id = params[:product_id].to_i
    amount_sold = params[:amount_sold].to_i

    product = Product.find_by(id: product_id)
    return redirect_to new_admin_sale_path, alert: "Producto no encontrado" unless product
    return redirect_to new_admin_sale_path, alert: "Cantidad ingresada mayor al stock actual" if amount_sold <= 0 || amount_sold > product.available_stock

    session[:product_list] ||= []

    actual_product = session[:product_list].find { |prod| prod["product_id"] == product_id }

    if actual_product
      if actual_product["amount_sold"] + amount_sold > product.available_stock
        return redirect_to new_admin_sale_path, alert: "Cantidad ingresada mayor al stock actual"
      else
        actual_product["amount_sold"] += amount_sold
      end
    else
      session[:product_list] << {
        "product_id" => product_id,
        "amount_sold" => amount_sold,
        "sale_price" => product.unit_price
      }
    end

    redirect_to new_admin_sale_path, notice: "Producto agregado correctamente"
  end

  def clear_product_list
    session[:product_list] = nil
    flash[:notice] = "Lista de productos vaciada."
    redirect_to new_admin_sale_path
  end

  # GET /sales/1/edit
  def edit
    @products = Product.all
  end

  # DELETE /sales/1
  def destroy
    @sale.logic_delete
    redirect_to admin_sales_path, notice: "Venta cancelada exitosamente."
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
      :employee_id
    )
  end
end
