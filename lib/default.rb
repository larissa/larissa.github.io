# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Rendering

require 'set'

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
