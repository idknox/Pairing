require 'spec_helper'

describe ProtectedPagesController do
  it 'requires the user to be logged in' do
    get 'dashboard'
    expect(flash[:notice]).to eq I18n.t('signed_in_user_required_for_page')
    expect(response).to redirect_to root_path
  end
end