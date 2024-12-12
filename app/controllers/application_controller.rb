class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from CanCan::AccessDenied, with: :render_401

  private

  def render_404
    @error = {
      code: "404",
      message: "No se encontró la página solicitada"
    }
    render template: "error", status: :not_found
  end

  def render_401
    @error = {
      code: "401",
      message: "No tienes permisos para acceder a esta página"
    }
    render template: "error", status: :unauthorized
  end

  protected

  # Metodos sobreescritos para redireccionar al usuario
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || admin_products_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
