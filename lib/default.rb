# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc::Helpers::LinkTo
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Blogging

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
