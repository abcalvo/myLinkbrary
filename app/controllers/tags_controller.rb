class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tags = Tag.where(user: current_user).order(:tag_name)
  end

  def show
    @tag_name = Tag.find(params[:id]).tag_name
    @links = Tag.find(params[:id]).links.order(created_at: :desc)
  end

  def create_if_necessary(tag_name)
    if !(Tag.exists?(user: current_user, tag_name: tag_name)) then
      @tag = Tag.new(user: current_user, tag_name: tag_name)

      @tag.save
    end
  end

  def create2
    @tag = Tag.new(user: current_user, tag_name: tag_name)

    @tag.save
  end
end
