class Event < ActiveRecord::Base
 serialize :content

 belongs_to :project

 def self.create_for(project_id, object, event_type)
   event = Event.new
   event.project_id = project_id
   event.event_type = event_type_for(object, event_type)
   event.content = {}
   event.associate_with(object)
   event.save
 end

 def self.event_type_for(object, event_type)
   "#{object.class.name.underscore}_#{event_type}"
 end

 def associate_with(object)
   self.content[:owner_class] = object.class
   self.content[:owner_id] = object.id
 end

 def to_partial_path
   "/events/#{event_type}"
 end
end
