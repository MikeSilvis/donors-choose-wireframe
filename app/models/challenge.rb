class Challenge < ActiveRecord::Base
  attr_accessible :title, :amount,
                  :project_id, :display_media

  monetize :target_funding_cents, allow_nil: true

  belongs_to :project
  belongs_to :user

  has_many :challenge_evidences

  validates_presence_of     :title, :display_media
  validates_numericality_of :amount, :greater_than_or_equal_to => 0
  validate                  :amount_versus_donors_choose_fund, :on => :create

  after_create :calculate_target_funding

  def mark_as_met
    self.met = true
    save
  end

  def amount_currency
    Money.new(amount * 100)
  end

  def name
    user.name
  end

  def owner_avatar
    user.profile_image_url
  end


  private

  def amount_versus_donors_choose_fund
    if self.amount && self.project.cost_to_complete.to_i < self.amount
      errors.add(:amount, "Amount must be less than the cost to complete")
    end
  end


  def calculate_target_funding
    self.target_funding_cents = (project.raised_to_date.cents + amount_currency.cents)
    save
  end
end
