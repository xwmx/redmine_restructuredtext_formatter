# Redmine reStructuredText Formatter

This is a Redmine plugin for supporting reStructuredText as a wiki format using either [RbST](http://rdoc.info/projects/alphabetum/rbst), which can convert all RST but is slow, or [PandocRuby](http://rdoc.info/projects/alphabetum/pandoc-ruby), which only supports a subset of RST but is fast.

## Notes

### RbST/docutils version (master branch)

This is potentially quite slow. RbST processes reStructuredText via Python's docutils, and docutils is slow. As far as I can tell, Redmine always formats text using a helper on each request, which means this plugin will likely add a few tenths of a second to each request, possibly more. On my machine, normal views take 450-550ms to render with the default textile option and 650-750 with this plugin. Heavily marked-up pages like the [RST cheat sheet](http://docutils.sourceforge.net/docs/user/rst/cheatsheet.txt) bumps it up to 1.2s. I wouldn't recommend this for public-facing pages, but it's probably OK for private Redmine instances.

### PandocRuby version (pandoc-ruby branch)

Pandoc is much faster than docutils and should be roughly as fast as the native textile, but it only supports a subset of RST, so some features like tables are not available. This version is available on the `pandoc-ruby` branch. This branch doesn't have a toolbar.

## Installation

### RbST/docutils version

* Install Python and [docutils](http://docutils.sourceforge.net/)
* gem install RbST
* cd /path/to/redmine
* script/plugin install git://github.com/ebrahim/redmine\_restructuredtext\_formatter.git
* Start Redmine

### PandocRuby version

* Install [Pandoc](http://johnmacfarlane.net/pandoc/)
* gem install pandoc-ruby
* cd /path/to/redmine/vendor/plugins
* git clone git://github.com/alphabetum/redmine\_restructuredtext\_formatter.git
* cd redmine\_restructuredtext\_formatter
* git branch --track pandoc-ruby origin/pandoc-ruby
* git checkout pandoc-ruby
* Start Redmine

## Notes

This plugin was derived directly from Larry Baltz's [redmine\_markdown\_formatter](http://github.com/bitherder/redmine_markdown_formatter).
