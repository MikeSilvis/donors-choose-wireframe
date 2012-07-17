class ChallengeObserver < ActiveRecord::Observer
  def after_create(model)
    Event.create_for(model, :created)
  end

  def around_save(model)
    if model.changed_attributes.keys.include?("met") && model.met
      Event.create_for(model, :met)
    end
    yield
  end
end
