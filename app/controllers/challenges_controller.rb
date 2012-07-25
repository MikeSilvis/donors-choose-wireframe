class ChallengesController < ApplicationController
  before_filter :find_project
  before_filter :authenticate_user, only: [:create]

  def new
    @challenge = Challenge.new(params[:challenge])
    @sample_challenges = Challenge.order("created_at DESC").limit(3)
  end

  def create
    @challenge = current_user.challenges.new(params[:challenge])
    if @challenge.save
      redirect_to project_path(@project)
      flash[:notice] = "Your challenge has been created"
    else
      @sample_challenges = Challenge.order("created_at DESC").limit(3)
      render "new"
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
