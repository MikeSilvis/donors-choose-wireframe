require 'donors_choose'
class Project < ActiveRecord::Base
  attr_accessible :cost_to_complete
  has_many :challenges
  has_many :messages
  has_many :events

  def create_from_donors_choose_url(url)
    response = DonorsChooseApi::Project.find_by_id(self.donors_choose_id)
    attrs = response.attributes
    attrs.each do |key, value|
      self.send("#{key}=".to_sym, value)
    end
    save
  end


  # def to_param
  #   "#{self.id}-#{self.title.parameterize}"
  # end
end
