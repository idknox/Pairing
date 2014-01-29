class GiveFeedback
  def initialize(recipient, provider, comment)
    @recipient = recipient
    @provider = provider
    @comment = comment
    @callbacks = Hash.new(->() {})
  end

  def success(callback)
    @callbacks[:success] = callback
  end

  def failure(callback)
    @callbacks[:failure] = callback
  end

  def run!
    entry = FeedbackEntry.create(recipient_id: @recipient.id, provider_id: @provider.id, comment: @comment)
    if entry.persisted?
      @callbacks[:success].call(entry)
    else
      @callbacks[:failure].call(entry)
    end
  end
end