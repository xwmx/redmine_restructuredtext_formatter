# Redmine reStructuredText Formatter

This is a redmine plugin for supporting reStructuredText as a wiki format using the [PandocRuby gem](http://rdoc.info/projects/autodata/pandoc-ruby).

## Notes

Pandoc is much faster than docutils and should be roughly as fast as the native textile, but it only supports a subset of RST, so some features like tables are not available.

## Installation

* Install [Pandoc](http://johnmacfarlane.net/pandoc/)
* gem install pandoc-ruby
* cd vendor/plugins
* git clone git://github.com/autodata/redmine\_restructuredtext\_formatter.git
* git checkout pandoc-ruby
* Start Redmine

## Credits

This plugin was derived directly from Larry Baltz's [redmine\_markdown\_formatter](http://github.com/bitherder/redmine_markdown_formatter).