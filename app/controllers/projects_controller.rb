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
      flash[:notice] = "Thanks for adopting this project! Use this dashboard to manage your efforts!"
    else
      flash[:notice] = "This project already exists. You can contribute to it here!"
    end
    redirect_to project_path(project)
  end

  def show
    @project = Project.find(params[:id])
  end
end
