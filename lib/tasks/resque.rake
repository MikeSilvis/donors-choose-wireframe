require 'resque/tasks'
ENV["QUEUE"] = "*"
task "resque:setup" => :environment do
	# Temp hack for unknown load order bug
	ActiveRecord::Base
end
task "jobs:work" => "resque:work"