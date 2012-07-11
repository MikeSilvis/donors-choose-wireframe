class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    url = params[:project][:proposal_url]
    id = url.scan(/\d{4,}/).first
    project = Project.find_or_initialize_by_donors_choose_id(id)
    if project.new_record?
      project.create_from_donors_choose_url(url)
    end
    redirect_to project_path(project)
  end

  def show
    @project = Project.find(params[:id])
  end
end
