class SessionsController < ApplicationController
  def create
    email = request.env['omniauth.auth']['info']['email']

    user = User.find_by(email: email)

    redirect_to root_path, notice: I18n.t("welcome_message", first_name: user.first_name, last_name: user.last_name)
  end

  def failure
    flash[:error] = I18n.t("login_failed")
    redirect_to root_path
  end
end