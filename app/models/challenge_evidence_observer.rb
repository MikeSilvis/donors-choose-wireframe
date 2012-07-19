class ChallengeEvidenceObserver < ActiveRecord::Observer

  def after_create(challenge_evidence)
    event = Event.create_for(challenge_evidence.challenge.project_id, challenge_evidence, :posted)
    event.content[:display_html] = challenge_evidence.embed
    event.save
  end
end
