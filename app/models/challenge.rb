class Challenge < ActiveRecord::Base
  attr_accessible :title, :amount,
                  :project_id, :display_media

  monetize :target_funding_cents, allow_nil: true

  belongs_to :project
  belongs_to :user

  has_many :challenge_evidences

  validates :title, :presence => { message: I18n.t(:challenge_title_missing) }
  validates :display_media, :presence => {
                              message: I18n.t(:challenge_media_missing) }
  validates :amount, :numericality => {
                            :greater_than_or_equal_to => 0,
                            :message => I18n.t(:challenge_amount_not_a_number) }
  validate  :amount_versus_donors_choose_funds => { on: :create }

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

  def amount=(number)
    amount = number.to_s.gsub('$', '')
    write_attribute(:amount, amount)
  end

  private

  def amount_versus_donors_choose_funds
    if self.amount && self.project.cost_to_complete.to_i < self.amount
      errors.add(:amount, I18n.t(:challenge_amount_too_much))
    end
  end


  def calculate_target_funding
    self.target_funding_cents = (project.raised_to_date.cents +
      amount_currency.cents)
    save
  end
end
