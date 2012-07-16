class ProjectImporter
  @queue = :update_project_queue

  def self.perform
		@projects  = Project.all
		@projects.each do |project|
			previous_cost = project.cost_to_complete.to_i
			project.create_from_donors_choose_url(project.donors_choose_id)
			new_cost = project.cost_to_complete.to_i
			update_challenge_goal(previous_cost, new_cost, project)
		end
  end

  def self.update_challenge_goal(previous_cost, new_cost, project)
  	if previous_cost != new_cost 
  		adjustment_to_goal = previous_cost - new_cost
  		project.challenges.each do |challenge|
  			new_goal = challenge.amount - adjustment_to_goal
        if new_goal < 0
          new_goal = 0
        end
  			challenge.update_attributes(:amount => new_goal)
  		end  		
  	end
  end
end