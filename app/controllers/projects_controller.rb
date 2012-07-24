class ProjectsController < ApplicationController
  def new
    @projects = Project.limit(10)
    @project = Project.new
  end

  def create
    url = params[:project][:proposal_url]
    if Project.valid_url(url)
      project = Project.from_donors_choose_url(url)
      if project.new_record?
        project.set_attrs_from_donors_choose(url)
        redirect_to new_project_challenge_path(:project_id => project.id)
        flash[:notice] = "Thanks for adopting this project! To kick this party off right, create a new challenge!"
      else
        redirect_to project_path(project)
        flash[:notice] = "This project already exists. You can contribute to it here!"
      end
    else
      redirect_to root_path
      flash[:error] = "Sorry, we are unable to match the URL with a Donors Choose project"
    end
  end

  def show
    @project = Project.find(params[:id])
    @challenges = Challenge.where("project_id = ?", params[:id]).order("amount ASC").limit(6)
  end
end
