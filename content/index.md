---
title: virtual space
---

<% sorted_articles.each do |post| %>
  <% render 'post', { home_page: true, item: post } do %>
    <%= post.compiled_content %>
  <% end %>
<% end %>

