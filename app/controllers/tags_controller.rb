class TagsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tags = Tag.where(user: current_user).order(:tag_name)
  end

  def show
    tag = Tag.where(user: current_user).find_by_id(params[:id])

    @tag_name = tag.nil? ? nil : tag.tag_name
    @links =  tag.nil? ? nil : tag.links.order(created_at: :desc)
  end
end
