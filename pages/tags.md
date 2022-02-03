---
layout: post
title: Tags
permalink: /tags/
content-type: static
---

{% comment %}

  - https://talk.jekyllrb.com/t/url-passed-parameter/1599/6
  - https://jekyllrb.com/docs/plugins/generators/
  - https://jekyllrb.com/docs/step-by-step/06-data-files/
  - https://www.siteleaf.com/blog/tag-pages-in-jekyll-and-siteleaf/

Tag clouds:
 - https://www.reddit.com/r/Jekyll/comments/s4gflb/pulling_tags_from_posts_in_bloghtml_to_filter/?utm_source=share&utm_medium=web2x&context=3
 - https://victorwynne.com/tags/
   - https://github.com/victorwynne/victorwynne/blob/main/tags.md
 - https://jpasholk.com/blog/2018/04/22/tags-archive-in-liquid-on-a-github-pages-jekyll-site/
 - https://blog.lanyonm.org/articles/2013/11/21/alphabetize-jekyll-page-tags-pure-liquid.html
 - https://github.com/jekyll/jekyll/issues/6291
 - https://silvae86.github.io/2020/05/06/jekyll-tags-page-forpages-and-posts/
{% endcomment %}

<main>
    {% comment %} We use <> to allow the usage of spaces in tag names {% endcomment %}
    {% assign tags = site.notes | map: 'tags' | join: '<>' | split: '<>' | uniq | sort %}
    {% for tag in tags %}
        {% assign ftag = tag | remove: ',' %}
        {% comment %} formatted / pretty tag, separate this from the actual jekyll-recognized tag {% endcomment %}

        {% assign tagnotes = '' | split: '' %}
        {% for note in site.notes %}
          {% if note.tags contains tag %}
            {% assign tagnotes = tagnotes | push: note.title %}
          {% endif %}
        {% endfor %}
      
      <details style="padding-top: 1em;" open>
        <summary class="tag-header" id="{{ ftag | cgi_escape }}">
          <a href="#{{ ftag | cgi_escape }}" class="noselect tag-identifier" style="text-decoration: none; margin-right: -5px; font-size: 0.6em; color: var(--text-sub);">#</a>
          {{ ftag | capitalize }}
          <sup style="font-size: 0.5em; color: var(--text-sub);">{{ tagnotes.size }}</sup>
        </summary>

        {%- for note in tagnotes -%}
          <li style="list-style: none;">
            [[{{ note }}]]
          </li>
        {%- endfor -%}
      </details>
    {%- endfor -%}

    <br/><br/>
</main>

{% raw %}
<style>
.category-content a {
    text-decoration: none;
    color: #4183c4;
}

.category-content a:hover {
    text-decoration: underline;
    color: #4183c4;
}
</style>
{% endraw %}
