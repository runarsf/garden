---
layout: post
title: By Tags
permalink: /tags/
content-type: static
---

<!-- TODO Display nested tags properly -->
<!-- TODO Process inline hashtag-tags? -->
<!-- TODO Show page tags as clickable pills on top of note -->
<!-- FIXME 'tags: nix, linux' leads to the tags 'nix,' and 'linux' -->

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

<main>
    {% assign tags =  site.notes | map: 'tags' | join: ' '  | split: ' ' | uniq %}
    {% for tag in tags %}
        <h3 id="{{ tag }}">{{ tag | capitalize }}</h3>
        {%- for note in site.notes -%}
            {%- if note.tags contains tag -%}
                <li style="padding-bottom: 0.6em; list-style: none;"><a href="{{note.url}}">{{ note.title }}</a></li>
            {%- endif -%}
        {%- endfor -%}
    {%- endfor -%}
    <br/>
    <br/>
</main>

