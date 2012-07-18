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
    events = project.events

    (messages + events).sort_by(&:created_at).reverse
  end
end
