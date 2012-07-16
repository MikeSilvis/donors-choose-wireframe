class Challenge < ActiveRecord::Base
  attr_accessible :name_of_challenger, :title_of_challenge, :amount,
                  :project_id

  belongs_to :project
  has_one :challenge_creation_event

  validates_presence_of :name_of_challenger, :title_of_challenge
  validates_numericality_of :amount, :greater_than => 0
  validate :amount_versus_donors_choose_fund, :on => :create

  after_create :create_challenge_creation_event

  def amount_versus_donors_choose_fund
    if self.amount && self.project.cost_to_complete.to_i < self.amount
      errors.add(:amount, "Amount must be less than the cost to complete")
    end
  end

  def create_challenge_creation_event
    event = ChallengeCreationEvent.new
    event.challenge_id = self.id
    event.save
  end
end
