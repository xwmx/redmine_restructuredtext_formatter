module RedmineRestructuredtextFormatter
  module Helper
    unloadable

    def wikitoolbar_for(field_id)
      heads_for_wiki_formatter
      url = Redmine::Utils.relative_url_root +
        Engines::RailsExtensions::AssetHelpers.plugin_asset_path('redmine_restructuredtext_formatter', 'help', 'restructuredtext_syntax.html')
      help_link = l(:setting_text_formatting) + ': ' +
        link_to(l(:label_help), url,
        :onclick => "window.open(\"#{url}\", \"\", \"resizable=yes, location=no, width=300, height=640, menubar=no, status=no, scrollbars=yes\"); return false;")

      javascript_tag("var toolbar = new jsToolBar($('#{field_id}')); toolbar.setHelpLink('#{help_link}'); toolbar.draw();")
    end


    def initial_page_content(page)
      line = '=' * page.pretty_title.mb_chars.length
      "#{line}\n#{page.pretty_title}\n#{line}"
    end

    def heads_for_wiki_formatter
      unless @heads_for_wiki_formatter_included
        content_for :header_tags do
          javascript_include_tag('jstoolbar/jstoolbar') +
          javascript_include_tag('restructuredtext', :plugin => 'redmine_restructuredtext_formatter') +
          javascript_include_tag("jstoolbar/lang/jstoolbar-#{current_language.to_s.downcase}") +
          javascript_include_tag("lang/restructuredtext-#{current_language.to_s.downcase}", :plugin => 'redmine_restructuredtext_formatter') +
          stylesheet_link_tag('jstoolbar') +
          stylesheet_link_tag('restructuredtext', :plugin => 'redmine_restructuredtext_formatter')
        end
        @heads_for_wiki_formatter_included = true
      end
    end
  end
end
