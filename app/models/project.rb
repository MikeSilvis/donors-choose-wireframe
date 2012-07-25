require 'donors_choose'
class Project < ActiveRecord::Base
  attr_protected :id
  has_many :challenges
  has_many :messages
  has_many :events
  monetize :amount_raised_cents, allow_nil: true

  after_create :sanitize_data

  # self.column_names.each do |attr|
  #   define_method(attr) do
  #     HTMLEntities.new.decode(attributes[attr]) unless attr = "amount_raised_cents"
  #   end
  # end

  def self.valid_url(url)
    return true unless DonorsChooseApi::Project.find_by_url(url) ==
      "Invalid Donors Choose Url"
  end

  def self.from_donors_choose_url(url)
    dc_id = donors_choose_id_from_url(url)
    self.find_or_initialize_by_donors_choose_id(dc_id)
  end

  def set_attrs_from_donors_choose(url)
    self.attributes = donors_choose_attributes
    save
  end

  def refresh_donors_choose_data
    self.attributes = donors_choose_attributes
    save
  end

  def cents_to_complete
    (cost_to_complete.to_f * 100).to_i
  end

  def raised_to_date
    calculate_amount_raised_cents unless amount_raised
    amount_raised
  end

  def currency_to_complete
    Money.new(cents_to_complete)
  end

  def currency_total_price
    Money.new(total_price.to_f*100)
  end

  private

  def donors_choose_attributes
    DonorsChooseApi::Project.find_by_id(self.donors_choose_id).attributes
  end

  def self.donors_choose_id_from_url(url)
    url.scan(/\d{4,}/).first
  end

  def calculate_amount_raised_cents
    self.amount_raised_cents = ((total_price.to_f - cost_to_complete.to_f) *
      100).to_i
    save
  end

  def sanitize_data
    attributes.each do |attr|
      attributes[attr] = HTMLEntities.new.decode(attr)
    end
  end
end
