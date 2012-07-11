class Project < ActiveRecord::Base
  # attr_accessible :title, :body
  def create_from_donors_choose_url(url)
    response = DonorsChooseApi::Project.find_by_id(self.id)
    attrs = response.attributes
    attrs.each do |key, value|
      self.send("#{key}=".to_sym, value)
    end
    save
  end
end
