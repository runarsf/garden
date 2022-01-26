---
layout: post
title: About
permalink: /about/
content-type: static
---

Hallo! 👋

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
