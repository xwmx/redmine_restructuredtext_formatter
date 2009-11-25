# Redmine reStructuredText Formatter

This is a redmine plugin for supporting reStructuredText as a wiki format using the [RbST reStructuredText gem](http://rdoc.info/projects/autodata/rbst).

**Note:** this is potentially slow. RbST processes reStructuredText via Python's docutils, and docutils is slow. As far as I can tell, Redmine formats text using a helper on each request, which means this plugin will likely add a few tenths of a second to each request. Maybe more.

This plugin was basically created directly from Larry Baltz's [redmine\_markdown\_formatter](http://github.com/bitherder/redmine_markdown_formatter).

## Installation

* Install Python and [docutils](http://docutils.sourceforge.net/)
* gem install RbST
* script/plugin install git://github.com/autodata/redmine\_restructuredtext\_formatter.git
* Start Redmine