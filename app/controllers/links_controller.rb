class LinksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @links = Link.where(user: current_user)
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    if params.has_key?(:url) then
      @url = params[:url]
    end

    if params.has_key?(:title) then
      @title = params[:title]
    end
  end

  def create
    @link = Link.new(link_params)

    @link.user = current_user

    @link.save
    redirect_to @link
  end

  private
  def link_params
    params.require(:link).permit(:url, :title, :notes)
  end
end
