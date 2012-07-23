class Message < ActiveRecord::Base
  belongs_to :project
  attr_accessible :name, :body, :display_html, :project_id

  validates_presence_of :name, :body, :project_id

  before_create :parse_for_url

  def parse_for_url
    self.display_html = MediaUrlParser.new(self.body).check_for_media.html
  end

end