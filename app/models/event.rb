class Event < ActiveRecord::Base
 serialize :content

 belongs_to :project

 # Creates an event of appropriate type in a project's feed
 #
 # @param [Integer] project_id the id of the project for the event
 # @param [Object] object the object that the event pertains to -- specifically an ActiveRecord Model
 # @param [Symbol] event_type the type of event to be created; e.g. `:created`, `:posted`, `:met`
 # @return [Event] returns self after saving

 def self.create_for(project_id, object, event_type)
   event = Event.new
   event.project_id = project_id
   event.event_type = event_type_for(object, event_type)
   event.save
 end

 # Returns the formatted string for referencing event types
 #
 # @example event_type for challenge created
 #   Event.event_type_for(Challenge.new, :created) #=> "challenge_created"
 #
 # @param [Object] object the ActiveRecord model the event pertains to
 # @param [Symbol] event_type the type of event to be created
 # @return [String] returns the snake-cased event type name by combining class name with event_type

 def self.event_type_for(object, event_type)
   "#{object.class.name.underscore.downcase}_#{event_type}"
 end
end
