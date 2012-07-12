class MessagesController < ApplicationController
  def create
    project = Project.find(params[:project_id])
    message = project.messages.new(params[:message])
    if message.save
      redirect_to project_path(project)
    else
      redirect_to project_path(project), flash: { error: message.errors.full_messages }
    end
  end
end
