# [Garden](https://publish.runarsf.dev)

All my notes are private by design, stashed away in a submodule only I (and this repo, with a [PAT](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)) can access.<br/>
The notes are processed by a custom GitHub [workflow](https://github.com/runarsf/garden/blob/main/.github/workflows/deploy.yaml) with Jekyll, and published content is pushed to the [gh-pages](https://github.com/runarsf/garden/tree/gh-pages) branch, which is being [served](https://publish.runarsf.dev) by GitHub pages.<br/>
I write all my notes in [Obsidian](https://obsidian.md), and selectively publish them by adding the `published: true` tag to the note's frontmatter, commit and push my changes, and remotely trigger a workflow build from within Obsidian using a worflow dispatch event.<br/>

<br/>

> **Garden** © [runarsf](https://github.com/runarsf).<br/>
> Based on [Jekyll-Garden](https://github.com/Jekyll-Garden/jekyll-garden.github.io) and released under the [MIT License](https://github.com/runarsf/garden/blob/main/LICENSE).
