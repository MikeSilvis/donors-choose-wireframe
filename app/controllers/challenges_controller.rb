class ChallengesController < ApplicationController
  before_filter :find_project

  def new
    @challenge = Challenge.new(params[:challenge])
  end

  def create
    @challenge = Challenge.new(params[:challenge])
    if @challenge.save
      redirect_to project_path(@project)
      flash[:notice] = "Your challenge has been created"
    else
      render :new
      flash[:error] = "Your challenge cannot be created"
    end
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
