class ChallengeEvidencesController < ApplicationController
  before_filter :authenticate_user
  before_filter :authorize_user

  def create
    @challenge_evidence = current_user.challenge_evidences.new(params[:challenge_evidence])
    if @challenge_evidence.save
      flash[:notice] = "Your evidence has been logged"
      redirect_to project_challenge_path(project, challenge)
    else
      render :new
      flash[:error] = "Your evidence could not be saved"
    end
  end

  private

  def authorize_user
    unless current_user == challenge.user
      flash[:notice] = "You must be the owner of the challenge to add evidence"
      redirect_back_or_to_root
    end
  end

  def challenge
    @challenge ||= Challenge.find(params[:challenge_id])
  end

  def project
    @project ||= challenge.project
  end
end
