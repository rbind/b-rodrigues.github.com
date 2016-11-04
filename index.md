---
layout: page
title: Econometrics and Free Software
tagline: PhD Candidate at BÉTA, University of Strasbourg and Research Assistant at STATEC, Luxembourg
---
{% include JB/setup %}

<div style="float: left;margin: 0px 80px 50px 0px">
    <img src="/assets/images/profile.png" width="223" height="360"/>
</div>

Welcome to my page.
If you <strike>are</strike> were one of my students, you're probably interested in the [Teachings](/pages/Teachings.html) (if links are dead, don't hesitate to send me an email!) and [Software](/pages/software.html) pages. If you're a fellow PhD candidate, maybe my [Research](/pages/Research.html) will be of interest to you. If you want to [email me](mailto:contact@brodrigues.co), you can click on the red envelope at the top-right corner of any page. You can also follow me on [twitter](https://twitter.com/brodriguesco). I sometimes write blog posts about R, and hope to contribute in this way to [R-bloggers](http://www.r-bloggers.com/).

  
Blog
====

<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>


