class LinksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @links = Link.where(user: current_user).order(created_at: :desc)
  end

  def edit_links
    @links = Link.where(user: current_user).order(created_at: :desc)
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

  def edit
    @link = Link.find(params[:id])
  end

  def create
    @link = Link.new(link_params)

    @link.user = current_user
    @link.save

    tags = params[:link][:tags]
    save_tags(tags)

    redirect_to @link
  end

  def update
    @link = Link.find(params[:id])

    if @link.update(link_params)
      redirect_to @link
    else
      render 'edit'
    end
  end

  private
  def link_params
    params.require(:link).permit(:url, :title, :notes)
  end

  def save_tags(tags)
    array_of_tag_names = tags.split(",")
    array_of_tag = Array.new

    array_of_tag_names.each do |tag_name|
      tag_name = normalize_tag_name(tag_name)

      tag = Tag.where(tag_name: tag_name, user: current_user).first_or_create()
      array_of_tag << tag
    end

    @link.tags = array_of_tag
  end

  def normalize_tag_name(tag_name)
    # Delete leading and trailing whitespaces
    # Substitute whitespaces with underscores
    # And convert to downcase
    tag_name.strip.tr(" ", "_").downcase
  end
end
