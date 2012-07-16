class ProjectImporter
	@queue = :update_project_queue

	def self.perform
		raise "boom"
	end
end