class EvidenceObserver < ActiveRecord::Observer
  observe :challenge_evidence

  def after_create(challenge_evidence)
    event = Event.create_for(challenge_evidence.challenge.project_id, challenge_evidence, :posted)
    event.content = {}
    event.content[:display_html] = challenge_evidence.embed
    event.save
  end
end
