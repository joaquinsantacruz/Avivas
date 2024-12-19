class Admin::UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!
  before_action :set_roles, only: [ :new, :create, :edit ]
  load_and_authorize_resource

  # GET /users
  def index
    @users = User.where.not("username LIKE ? OR email LIKE ?", "*%", "*%")
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
      redirect_to admin_user_path(@user), notice: "Usuario creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /users/:id/edit
  def edit
  end

  # PATCH/PUT /users/:id
  def update
    if params[:role].present?
      @user.assign_role(params[:role])
    end

    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "Usuario actualizado exitosamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.logic_delete
    redirect_to admin_users_path, notice: "Usuario eliminado exitosamente."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :phone, :password, :entry_date, :role_ids)
  end

  def set_roles
    @roles = if current_user.has_role?(:admin)
               Role.all
    elsif current_user.has_role?(:manager)
               Role.where.not(name: "admin")
    else
               Role.none
    end
  end
end
