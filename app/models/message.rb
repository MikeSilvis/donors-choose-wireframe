class Message < ActiveRecord::Base
  belongs_to :project

  attr_accessible :name, :body

  validates :name, presence: true
  validates :body, presence: true
  validates :project_id, presence: true
end
