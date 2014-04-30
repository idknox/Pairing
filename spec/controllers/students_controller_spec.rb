require "spec_helper"

describe StudentsController do
  let!(:cohort) { create_cohort }

  describe "GET #new" do
    it "doesn't allow guests" do
      get 'new', cohort_id: cohort.id
      expect(response).to redirect_to(root_path)
    end

    it "doesn't allow a normal user" do
      sign_in(create_user)
      get 'new', cohort_id: cohort.id
      expect(response).to redirect_to(root_path)
    end

    it "renders for a logged in instructor" do
      sign_in(create_user(role_bit_mask: User::INSTRUCTOR))
      get 'new', cohort_id: cohort.id
      expect(response).to render_template(:new)
    end
  end
end
