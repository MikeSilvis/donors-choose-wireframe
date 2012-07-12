class ChallengesController < ApplicationController
  def new
    @challenge = Challenge.new(params[:challenge], :project_id => params[:project_id])
  end

  def create
    raise params[:project_id].inspect
    @challenge = Challenge.new(params[:challenge])
    if @challenge.save
      redirect_to root_path
      flash[:notice] = "Your challenge has been created"
    else
      render :new
      flash[:error] = "Your challenge cannot be created"
    end
  end
end
