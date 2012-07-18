module ChallengeEvidencesHelper
  def display(challenge_evidence)
    if challenge_evidence.image
      image_tag(evidence.image_url(:thumb).to_s)
    else
      challenge_evidence.embed.html_safe
    end
  end
end
