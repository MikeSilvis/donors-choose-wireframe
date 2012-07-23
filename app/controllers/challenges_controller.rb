class ChallengesController < ApplicationController
  before_filter :find_project

  def new
    @challenge = Challenge.new(params[:challenge])
    @project = Project.find(params[:project_id])
  end

  def create
    @challenge = Challenge.new(params[:challenge])
    if @challenge.save
      redirect_to project_path(@project)
      flash[:notice] = "Your challenge has been created"
    else
      redirect_to new_project_challenge_path(@project)
      flash[:error] = "Your challenge cannot be created"
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    @challenge_evidence = @challenge.challenge_evidences.new
    @challenge_evidences = @challenge.challenge_evidences
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
