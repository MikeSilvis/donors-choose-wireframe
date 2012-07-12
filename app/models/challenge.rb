class Challenge < ActiveRecord::Base
  attr_accessible :name_of_challenger, :title_of_challenge, :minimum_amount,
                  :maximum_amount, :project_id

  belongs_to :project
end
