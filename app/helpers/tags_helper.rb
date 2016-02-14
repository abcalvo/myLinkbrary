module TagsHelper
  def flatten_tags_with_links(tags)
    flatten_tags_with_links = String.new
    tags.each do |tag|
      flatten_tags_with_links += (link_to tag.tag_name, tag_path(tag)) + ', '
    end

    flatten_tags_with_links.chomp(', ').html_safe
  end

  def flatten_tags(tags)
    flattened_tags = String.new
    tags.each do |tag|
      flattened_tags += tag.tag_name + ', '
    end

    flattened_tags.chomp(', ')
  end
end
