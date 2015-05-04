---
title: Tags
---

# Tags
<% get_tags(@items).sort.each do |tag| %>
  <h3><%= "#{tag} (#{items_with_tag(tag).count})" %></h3>
  <%= render 'tags', tag: tag %>
<% end %>
