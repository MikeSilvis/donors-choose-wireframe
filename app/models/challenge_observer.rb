class ChallengeObserver < ActiveRecord::Observer
  def after_create(challenge)
    Event.create_for(challenge.project_id, challenge, :created)
  end

  def around_save(challenge)
    if challenge.changed_attributes.keys.include?("met") && challenge.met
      Event.create_for(challenge.project_id, challenge, :met)
    end
    yield
  end
end
