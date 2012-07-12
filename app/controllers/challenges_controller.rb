class ChallengesController < ApplicationController
  def new
    @challenge = Challenge.new(params[:challenge])
  end
end
