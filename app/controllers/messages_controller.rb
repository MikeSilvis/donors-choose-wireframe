class MessagesController < ApplicationController
  def create
    project = Project.find(params[:project_id])
    @message = project.messages.new(params[:message])
    respond_to do |format|
      if @message.save
        format.js
        format.html { redirect_to project_path(project) }
      else
        format.html { render action: "new"}
      end
    end
  end
end
