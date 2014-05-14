class Users::SessionsController <  Devise::SessionsController

  #def auth_options
  #  { scope: resource_name, recall: "landing#login" }
  #end


  def after_sign_in_path_for(resource_or_scope)
    current_user.operator? ? operator_root_path : root_path
  end
end