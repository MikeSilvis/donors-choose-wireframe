class ChallengeEvidencesController < ApplicationController
  before_filter :find_challenge, :find_project

  def new
    @challenge_evidence = ChallengeEvidence.new
  end

  def create
    @challenge_evidence = ChallengeEvidence.new(params[:challenge_evidence])
    if @challenge_evidence.save
      flash[:notice] = "Your evidence has been logged"
      redirect_to project_challenge_path(@challenge.project, @challenge)
    else
      render :new
      flash[:error] = "Your evidence could not be saved"
    end
  end

  private
    def find_challenge
      @challenge = Challenge.find(params[:challenge_id])
    end

    def find_project
      @project = Project.find(@challenge.project_id)
    end
end
