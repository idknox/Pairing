class ViewFeedback
  def initialize(viewing_user, entry_to_view_id)
    @viewing_user = viewing_user
    @entry_to_view_id = entry_to_view_id
  end

  def run!
    entry = FeedbackEntry.find(@entry_to_view_id)
    if entry.recipient == @viewing_user
      entry.update_attributes(viewed: true)
    end

    if @viewing_user.is?(User::INSTRUCTOR) || entry.associated_with?(@viewing_user)
      entry
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end