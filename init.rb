# Redmine reStructuredText formatter
require 'redmine'
require 'redmine/wiki_formatting/restructuredtext/formatter'
require 'redmine/wiki_formatting/restructuredtext/helper'

Rails.logger.info 'Starting reStructuredText formatter for Redmine'

Redmine::Plugin.register :redmine_restructuredtext_formatter do
  name 'reStructuredText formatter'
  author 'William Melody'
  description 'reStructuredText formatting for Redmine'
  version '0.3.0-ebrahim'

  wiki_format_provider 'reStructuredText', Redmine::WikiFormatting::Restructuredtext::WikiFormatter, Redmine::WikiFormatting::Restructuredtext::Helper
end
