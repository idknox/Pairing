require "spec_helper"

describe Instructor::FeedbackEntriesController do
  before do
    @cohort = create_cohort

    sign_in(create_user(cohort: @cohort, role_bit_mask: User::INSTRUCTOR))

    @user1 = create_user(cohort: @cohort)
    @user2 = create_user(cohort: @cohort)
    create_user(cohort: create_cohort)
  end

  describe "GET #index" do
    it "only returns users for the current cohort" do
      get :index, cohort_id: @cohort.id

      expect(assigns(:users_for_filter)).to match_array(
                                              [@user1, @user2]
                                            )
    end
  end

  describe "GET #new" do
    it "only returns the users for the current user's cohort" do
      get :new, cohort_id: @cohort.id

      expect(assigns(:users_that_can_be_given_feedback)).to match_array(
                                                              [@user1, @user2]
                                                            )
    end
  end
end