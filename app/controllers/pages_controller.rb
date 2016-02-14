class PagesController < ApplicationController
  def index
    if user_signed_in? then
      redirect_to links_path
    end
  end
end
