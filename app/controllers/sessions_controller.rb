class SessionsController < ApplicationController
  def create
    email = request.env['omniauth.auth']['info']['email']
    github_username = request.env['omniauth.auth']['info']['nickname']

    user = User.find_by(email: email)
    user.update_attributes(github_username: github_username) unless user.github_username.present?

    redirect_to root_path, notice: I18n.t("welcome_message", first_name: user.first_name, last_name: user.last_name)
  end

  def failure
    flash[:error] = I18n.t("login_failed")
    redirect_to root_path
  end
end