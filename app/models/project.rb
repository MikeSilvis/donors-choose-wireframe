require 'donors_choose'
class Project < ActiveRecord::Base
  attr_protected :id
  has_many :challenges
  has_many :messages
  has_many :events

  def self.find_or_initialize_from_donors_choose_url(url)
    dc_id = donors_choose_id_from_url(url)
    self.find_or_initialize_by_donors_choose_id(dc_id)
  end

  def create_from_donors_choose_url(url)
    self.attributes = donors_choose_attributes
    save
  end

  private

  def donors_choose_attributes
    DonorsChooseApi::Project.find_by_id(self.donors_choose_id).attributes
  end

  def self.donors_choose_id_from_url(url)
    url.scan(/\d{4,}/).first
  end
end
