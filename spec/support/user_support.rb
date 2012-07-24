module UserSupport
  def sign_in(user)
    visit root_path
    click_link "Sign in with Twitter"
  end

  def sign_out
    visit root_path
    click_link "Sign out"
  end
end
