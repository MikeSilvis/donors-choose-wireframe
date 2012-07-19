class Challenge < ActiveRecord::Base
  attr_accessible :name, :title, :amount,
                  :project_id, :display_media

  belongs_to :project
  has_many :challenge_evidences

  validates_presence_of     :name, :title, :display_media
  validates_numericality_of :amount, :greater_than => 0
  validate                  :amount_versus_donors_choose_fund, :on => :create

  after_create :create_challenge_creation_event

  def create_challenge_creation_event
  end

  def mark_as_met
    self.met = true
    save
  end

  private

  def amount_versus_donors_choose_fund
    if self.amount && self.project.cost_to_complete.to_i < self.amount
      errors.add(:amount, "Amount must be less than the cost to complete")
    end
  end
end
