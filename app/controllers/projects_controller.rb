class ProjectsController < ApplicationController
  def new
    @projects = Project.limit(10)
    @project = Project.new
  end

  def create
    url = params[:project][:proposal_url]
    id = url.scan(/\d{4,}/).first
    project = Project.find_or_initialize_by_donors_choose_id(id)
    if project.new_record?
      project.create_from_donors_choose_url(url)
      redirect_to new_project_challenge_path(:project_id => project.id)
      flash[:notice] = "Thanks for adopting this project! To kick this party off right, create a new challenge!"
    else
      redirect_to project_path(project)
      flash[:notice] = "This project already exists. You can contribute to it here!"
    end
  end

  def show
    @project = Project.find(params[:id])
    @new_message = Message.new
    @challenges = Challenge.where("project_id = ?", params[:id])
    @feed = Feed.for(@project)
  end
end
