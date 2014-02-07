class APIController < ActionController::Base
  before_filter :authenticate_user!

  protected

  def of_current_user(model)
    model.where(:user => current_user)
  end
end
