class Message < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  attr_accessible :name, :body, :display_html, :project_id

  validates_presence_of :name, :body, :project_id

  before_create :parse_for_url

  def self.create_for_project_and_user(project, user, message)
    message = Message.new(message)
    message.project = project
    message.user = user
    message.save
  end

  def parse_for_url
    self.display_html = MediaUrlParser.new(self.body).check_for_media.display_html
  end

end
