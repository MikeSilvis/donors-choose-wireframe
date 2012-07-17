class Feed
  attr_accessor :project, :items

  def self.for(project)
    feed = self.new
    feed.project = project
    feed
  end

  def items
    @items ||= items_for_project
  end

  def items_for_project
    messages = project.messages
    challenge_creation_events = project.challenges.map { |c| c.challenge_creation_event }
    challenge_met_events = project.challenges.map { |c| c.challenge_met_event}

    (messages + challenge_creation_events + challenge_met_events).compact.sort_by(&:created_at).reverse
  end
end
