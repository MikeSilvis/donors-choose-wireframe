class ApplicationController
  def redirect_back_or_to_root
    redirect_to root_path
  end
end
