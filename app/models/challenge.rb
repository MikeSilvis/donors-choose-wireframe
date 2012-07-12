class Challenge < ActiveRecord::Base
  attr_accessible :name_of_challenger, :title_of_challenge, :amount,
                  :project_id

  belongs_to :project

  validates_presence_of :name_of_challenger, :title_of_challenge
  validates_numericality_of :amount, :greater_than => 0
end