---
title: virtual space
---

<% sorted_articles.each do |post| %>
  <% render '/abstract.html', { item: post } do %>
    <%= post.compiled_content %>
  <% end %>
<% end %>

