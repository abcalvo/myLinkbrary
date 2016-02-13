class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
  end

  def create
    @link = Link.new(link_params)

    @link.user = current_user

    @link.save
    redirect_to @link
  end

  private
  def link_params
    params.require(:link).permit(:url)
  end
end
