class ProtectedPagesController < ApplicationController
  include UserSessionHelper

  before_action :require_signed_in_user
end