class Event < ActiveRecord::Base
 serialize :content

 belongs_to :project

 def self.create_for(object, event_type)
   event = Event.new
   event.project = object.project
   event.event_type = event_type_for(object, event_type)
   event.save
 end

 def self.event_type_for(object, event_type)
   "#{object.class.name.underscore.downcase}_#{event_type}"
 end
end
