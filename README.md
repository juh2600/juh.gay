# Overview

This repository contains [my web site](https://juh.gay) and everything I use to build it, aside from third-party dependencies (Docker, Docker Compose, fish, pandoc...). It was designed to support authoring pages as [Markdown](https://www.markdownguide.org/basic-syntax/) in [Obsidian](https://obsidian.md/), then convert them to HTML. Taken together with the infrastructure components (docker, nginx, cron), the site can be deployed as a container that auto-updates itself periodically, rebuilding any changes that are committed to this Git remote.

# Setup workflow

1. Fork this repository, and clone your fork
2. Empty out src/
3. [optional] Create your own Obsidian vault in src/
4. Grep through everything and change anything that says "juh" to whatever you want it to say instead, I guess
5. Update docker-compose.yml to point to your repo/branch, configure update frequency, etc.
6. Deploy the docker-compose setup somewhere
7. Ping me when you find that this process doesn't work

# Authoring workflow

1. Create a markdown file somewhere under src/
2. Commit and push
3. Confirm that changes are reflected in your live deployment the next time your cronjob is scheduled to run (whatever you set it to in the docker-compose)

# Conventions

- The index file name is 'index.md'.
- Paths are rendered with the `.md` extension in the browser. This is kinda mostly so that we don't have to rewrite links when converting from MD to HTML. I wanted the fun features of Obsidian to work as intended, while not requiring any weird tricks from the author. Just write your markdown as markdown, write links to other pages as `/path/to/file.md`, and they should work out fine in Obsidian and on the web.
    - Come to think of it, this necessitates some additional server setup, which is done in nginx.conf. The http > server > types block tells nginx what MIME type to hand out for certain file extensions, which is required so that the browser doesn't just give up and dump the source or try to download every page.
- You can have a file and a directory with the same name (minus the extension): [essays/](https://juh.gay/essays/) and [essays.md](https://juh.gay/essays.md) may coexist in the same directory. A notice will be added to the top of essays.md allowing users to explore the tree with the same name.
    - I haven't tried creating a directory named `something.md`. Please don't.
- Stuff added in js/ and css/ and files/ are placed into top-level directories in the web server (/js/, /css/, /files/). You can configure which dirs get this treatment by changing $resources near the top of build/build.fish.

# Shortcomings

- The navbar hasn't been designed to support drop-downs that are mobile-friendly yet. I'm probably not going to work on that problem, either.
- If you wanted to write a raw HTML page alongside your markdown, off the top of my head, I don't remember how that would turn out. I might work on that someday.
