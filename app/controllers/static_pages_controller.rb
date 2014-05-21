class StaticPagesController < ApplicationController

  def index
    if current_user && current_user.operator?
      redirect_to operator_root_path
    end
  end

  def contact_center
  end

  def help
  end
end