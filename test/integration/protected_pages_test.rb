require 'test_helper'

describe ProtectedPagesController do
  it 'requires the user to be logged in' do
    get 'dashboard'
    flash[:notice].must_equal I18n.t('signed_in_user_required_for_page')
  end
end