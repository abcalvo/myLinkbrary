class LinksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @links = Link.where(user: current_user).order(created_at: :desc)
  end

  def show
    @link = Link.where(user: current_user).find_by_id(params[:id])
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
    @link = Link.where(user: current_user).find_by_id(params[:id])
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
      tags_to_update = params[:link][:tags]
      update_tags(tags_to_update)

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

  def update_tags(tags_to_update)
    # Get array of tag names on database
    array_of_actual_tags = @link.tags.map(&:tag_name)

    # Get array of tag names normalized to update
    array_of_tags_to_update = tags_to_update.split(",").map do |tag_name|
      normalize_tag_name(tag_name)
    end

    # Get the difference between both arrays, so we get the tag names to delete
    array_of_tags_to_delete = array_of_actual_tags - array_of_tags_to_update

    delete_tags(array_of_tags_to_delete)
    save_tags(tags_to_update)
  end

  def delete_tags(tags_to_delete)
    tags = @link.tags

    tags.each do |tag|
      # Check if this tag is referenced only in this link
      # and if we must delete that tag
      if tag.links.count == 1 && tags_to_delete.include?(tag.tag_name)
        tag.delete
      end
    end

    # Delete all the tags of this link
    tags.clear
  end

  def normalize_tag_name(tag_name)
    # Delete leading and trailing whitespaces
    # Substitute whitespaces with underscores
    # And convert to downcase
    tag_name.strip.tr(" ", "_").downcase
  end
end
