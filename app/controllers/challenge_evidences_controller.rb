class ChallengeEvidencesController < ApplicationController

  def new
    @challenge_evidence = ChallengeEvidence.new
  end

  def create
    @challenge_evidence = ChallengeEvidence.new(params[:challenge_evidence])
    if @challenge_evidence.save
      flash[:notice] = "Your evidence has been logged"
      redirect_to project_challenge_path(project, challenge)
    else
      render :new
      flash[:error] = "Your evidence could not be saved"
    end
  end

  private
    def challenge
      @challenge ||= Challenge.find(params[:challenge_id])
    end

    def project
      @project ||= challenge.project
    end
end
