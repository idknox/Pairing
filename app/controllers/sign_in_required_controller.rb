class SignInRequiredController < ApplicationController
  include UserSessionHelper

  layout 'signed_in'
  
  before_action :require_signed_in_user
end