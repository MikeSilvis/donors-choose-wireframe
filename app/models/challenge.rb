class Challenge < ActiveRecord::Base
  attr_accessible :name_of_challenger, :title_of_challenge, :amount,
                  :project_id, :display_media

  belongs_to :project
  has_many :challenge_evidence

  validates_presence_of     :name_of_challenger, :title_of_challenge, :display_media
  validates_numericality_of :amount, :greater_than => 0
  validate                  :amount_versus_donors_choose_fund, :on => :create

  def amount_versus_donors_choose_fund
    if self.amount && self.project.cost_to_complete.to_i < self.amount
      errors.add(:amount, "Amount must be less than the cost to complete")
    end
  end
end