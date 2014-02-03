class ViewFeedback
  def initialize(viewing_user, entry_to_view_id)
    @viewing_user = viewing_user
    @entry_to_view_id = entry_to_view_id
  end

  def run!
    if @viewing_user.is?(User::INSTRUCTOR)
      FeedbackEntry.find(@entry_to_view_id)
    else
      FeedbackEntry.given_to(@viewing_user).find(@entry_to_view_id).tap do |fe|
        fe.update_attributes(viewed: true)
      end
    end

  end
end