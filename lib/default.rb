# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Rendering

require 'set'

# Normalize all tags
module NormalizeTags
  def [](key)
    result = super
    key == :tags && !result.nil? ? result.map(&:downcase) : result
  end
end

class Nanoc::Item
  prepend NormalizeTags
end

# Helpers to format date
def format_date(unformated_date)
  unformated_date.strftime('%B %e, %Y')
end

def creation_date(item)
  format_date(item[:created_at])
end

def modification_date(item)
  format_date(item[:mtime])
end

def sorted_articles_by_month
  sorted_articles.group_by { |a| a[:created_at].strftime('%B') }
end

def get_tags(items)
  tags = Set[]
  items.each do |item|
    item[:tags].each { |t| tags << t } if item[:tags]
  end
  tags
end

def post_header(item)
  header = "<h1>#{item[:title]}</h1>
   <p class='post-header'>
     Posted on #{creation_date(item)}"
  tags = tags_for(@item, { base_url: 'localhost:3000/tag/' })
  header << "<br/>Tags: #{tags}" if  tags != '(none)'
  header << "</p>"
end
