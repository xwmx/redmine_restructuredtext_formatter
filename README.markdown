# Redmine reStructuredText Formatter

This is a redmine plugin for supporting reStructuredText as a wiki format using the [RbST reStructuredText gem](http://rdoc.info/projects/autodata/rbst).

## Warning

This is potentially quite slow. RbST processes reStructuredText via Python's docutils, and docutils is slow. As far as I can tell, Redmine always formats text using a helper on each request, which means this plugin will likely add a few tenths of a second to each request, possibly more. On my machine, normal views take 450-550ms to render with the default textile option and 650-750 with this plugin. Heavily marked-up pages like the [RST cheat sheet](http://docutils.sourceforge.net/docs/user/rst/cheatsheet.txt) bumps it up to 1.2s. I wouldn't recommend this for public-facing pages, but it's probably OK for private Redmine instances.

## Installation

* Install Python and [docutils](http://docutils.sourceforge.net/)
* gem install RbST
* script/plugin install git://github.com/autodata/redmine\_restructuredtext\_formatter.git
* Start Redmine

## Notes

This plugin was derived directly from Larry Baltz's [redmine\_markdown\_formatter](http://github.com/bitherder/redmine_markdown_formatter).