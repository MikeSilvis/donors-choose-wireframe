class ChallengesController < ApplicationController
  def new
    @challenge = Challenge.new(params[:challenge])
    @project_id = params[:project_id]
  end

  def create
    @challenge = Challenge.new(params[:challenge])
    if @challenge.save
      redirect_to project_path(@challenge.project_id)
      flash[:notice] = "Your challenge has been created"
    else
      render :new
      flash[:error] = "Your challenge cannot be created"
    end
  end
end
