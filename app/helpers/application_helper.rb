module ApplicationHelper
#  protect_from_forgery with: :exception
  
  include SessionsHelper

  private

  def require_admin_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
