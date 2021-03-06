class Link < ActiveRecord::Base
  validates_presence_of :url

  belongs_to :user

  has_and_belongs_to_many :tags, -> { order('tags.tag_name ASC') }
end
