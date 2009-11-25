# Redmine reStructuredText formatter
require 'redmine'

RAILS_DEFAULT_LOGGER.info 'Starting reStructuredText formatter for Redmine'

Redmine::Plugin.register :redmine_restructuredtext_formatter do
  name 'reStructuredText formatter'
  author 'William Melody'
  description 'reStructuredText formatting for Redmine'
  version '0.0.1'

  wiki_format_provider 'reStructuredText', RedmineRestructuredtextFormatter::WikiFormatter, RedmineRestructuredtextFormatter::Helper
end
