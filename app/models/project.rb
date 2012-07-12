class Project < ActiveRecord::Base
  has_many :challenges

  def create_from_donors_choose_url(url)
    response = DonorsChooseApi::Project.find_by_id(self.donors_choose_id)
    attrs = response.attributes
    attrs.each do |key, value|
      self.send("#{key}=".to_sym, value)
    end
    save
  end
end
