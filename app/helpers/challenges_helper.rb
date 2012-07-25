module ChallengesHelper
  def challenge_banner_message(challenge)
    if !challenge.met
      "<h1>This challenge is in progress.
       #{humanized_money_with_symbol challenge.amount_currency} to go!</h1>"
    elsif (challenge.met && challenge.challenge_evidences.count > 0)
      "<h1>This challenge has been completed. Check out the evidence!</h1>"
    else
      "<h1>This challenge has been met but there is no evidence. Demand the
       challenger live up to their word!</h1>"
    end
  end

  def challenge_banner_class(challenge)
    if !challenge.met
      "unmet"
    elsif (challenge.met && challenge.challenge_evidences.count > 0)
      "met"
    else
      "pending"
    end
  end
end
