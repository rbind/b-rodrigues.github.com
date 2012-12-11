---
layout: page
title: Bruno Rodrigues
tagline: PhD Candidate at BÉTA, University of Strasbourg
---
{% include JB/setup %}
Welcome to my page.
If you are one of my students, you're probably interested in the Teachings and Software pages. If you're a fellow PhD candidate, maybe my Research will be of interest to you. If you wish to contact me, you'll find all the information you need on the Contact page.
  
## Blog

<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>


