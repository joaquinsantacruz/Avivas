class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  # Metodos sobreescritos para redireccionar al usuario
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || admin_products_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
