class Admin::UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  # before_action :authenticate_user!

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.assign_role(params[:user][:role])
    if @user.save
      redirect_to [ :admin, @user ], notice: "Usuario creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /users/:id/edit
  def edit
  end

  # PATCH/PUT /users/:id
  def update
    @user = User.find(params[:id])

    if params[:role].present?
      @user.assign_role(params[:role])
    end

    if @user.update(user_params)
      redirect_to @user, notice: "Usuario actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
    redirect_to users_url, notice: "Usuario eliminado exitosamente."
  end

  private

  # Método para obtener un usuario específico.
  def set_user
    @user = User.find(params[:id])
  end

  # Filtros de parámetros permitidos para prevenir asignaciones masivas.
  def user_params
    params.require(:user).permit(:username, :email, :phone, :password, :entry_date, :role_ids)
  end
end
