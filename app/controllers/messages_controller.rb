class MessagesController < ApplicationController
  def create
    project = Project.find(params[:project_id])
    message = project.messages.new(params[:message])
    message.save
    redirect_to project_path(project)
  end
end
