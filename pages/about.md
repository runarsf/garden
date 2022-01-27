---
layout: post
title: About
permalink: /about/
content-type: static
---

Hallo! 👋<br/><br/>
These are my notes &mdash; a neatly <strike>un-</strike>organized collection of my thoughts and ideas.<br/>
Here you can find everything from new-norwegian literature notes to opinionated best practices for writing bash scripts and managing a docker environment.<br/>
You can find my notes <a href="../notes" style="color:var(--link);">here</a>, or perhaps filter by <a href="../tags" style="color:var(--link);">tags</a>.<br/>

[![Build Status](https://github.com/runarsf/garden/actions/workflows/deploy.yaml/badge.svg)](https://github.com/runarsf/garden/actions/workflows/deploy.yaml)

<main>
  <details><summary><b>About site</b></summary>
    <!-- TODO Make all links squiggly underlined -->
    This site is based on <a href="https://github.com/Jekyll-Garden/jekyll-garden.github.io">Jekyll-Garden</a> and is licensed under the MIT license.<br>
    Most of the content is provided for free (should you, contrary to expectations, want to use it) under a <a href="{{ site.copyright.license_url }}">{{ site.copyright.license }}</a>.
    <br><br>
    <code>
      {%- include_relative LICENSE -%}
      <!-- Has to be a symlink, because include_relative doesn't support pages in a higher directory -->
    </code>
  </details>
<script>
