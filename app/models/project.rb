require 'donors_choose'
class Project < ActiveRecord::Base
  attr_protected :id
  has_many :challenges
  has_many :messages
  has_many :events

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

  private

  def donors_choose_attributes
    DonorsChooseApi::Project.find_by_id(self.donors_choose_id).attributes
  end

  def self.donors_choose_id_from_url(url)
    url.scan(/\d{4,}/).first
  end
end
