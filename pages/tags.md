---
layout: post
title: By Tags
permalink: /tags/
content-type: static
---

{% comment %}
TODO Display nested tags properly
TODO Process inline hashtag-tags?
TODO Show page tags as clickable pills on top of note
FIXME 'tags: nix, linux' leads to the tags 'nix,' and 'linux'

  - https://talk.jekyllrb.com/t/url-passed-parameter/1599/6
  - https://jekyllrb.com/docs/plugins/generators/
  - https://jekyllrb.com/docs/step-by-step/06-data-files/
  - https://www.siteleaf.com/blog/tag-pages-in-jekyll-and-siteleaf/
{% endcomment %}

<main>
    {% comment %} We use <> to allow the usage of spaces in tag names {% endcomment %}
    {% assign tags = site.notes | map: 'tags' | join: '<>' | split: '<>' | uniq %}
    {% for tag in tags %}
        {% assign ftag = tag | remove: ',' %}
        {% comment %} formatted / pretty tag, separate this from the actual jekyll-recognized tag {% endcomment %}
        <h3 class="{{ ftag | replace: ' ', '-' | downcase }}" style="padding-top: 0.6em;">
          {{ ftag | capitalize }}
        </h3>
        {%- for note in site.notes -%}
            {%- if note.tags contains tag -%}
                <li style="list-style: none;">
                  [[{{note.title}}]]
                </li>
            {%- endif -%}
        {%- endfor -%}
    {%- endfor -%}
    <br/>
    <br/>
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
