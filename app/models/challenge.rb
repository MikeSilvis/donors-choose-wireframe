class Challenge < ActiveRecord::Base
  attr_accessible :name, :title, :amount,
                  :project_id, :display_media

  monetize :target_funding_cents, allow_nil: true

  belongs_to :project
  has_many :challenge_evidences

  validates_presence_of     :name, :title, :display_media
  validates_numericality_of :amount, :greater_than => 0
  validate                  :amount_versus_donors_choose_fund, :on => :create

  after_create :calculate_target_funding

  def mark_as_met
    self.met = true
    save
  end

  def cents_to_complete
    project.cents_to_complete - target_funding.cents
  end

  private

  def amount_versus_donors_choose_fund
    if self.amount && self.project.cost_to_complete.to_i < self.amount
      errors.add(:amount, "Amount must be less than the cost to complete")
    end
  end

  def cents_amount
    amount * 100
  end

  def calculate_target_funding
    self.target_funding_cents = (project.cents_to_complete - cents_amount)
    save
  end
end
