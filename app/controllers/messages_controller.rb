class MessagesController < ApplicationController
  before_filter :authenticate_user

  def create
    project = Project.find(params[:project_id])
    Message.create_for_project_and_user(project, current_user, params[:message])
    redirect_to project_path(project)
  end
end
