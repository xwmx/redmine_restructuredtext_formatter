module Redmine
  module WikiFormatting
    module Restructuredtext
      module Helper
        unloadable

        def wikitoolbar_for(field_id)
          heads_for_wiki_formatter
          url = "#{::Redmine::Utils.relative_url_root}/plugin_assets/redmine_restructuredtext_formatter/help/restructuredtext_syntax.html"
          javascript_tag(<<-EOD);
          var toolbar = new jsToolBar(document.getElementById('#{field_id}'));
          toolbar.setHelpLink('#{escape_javascript url}');
          toolbar.draw();
          $.each([#{::I18n.t(:direction) == 'rtl' ? "'.jstb_bq', '.jstb_unbq'" : ''}], function(i, button) { $(button).addClass('flip'); });
          EOD
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
              stylesheet_link_tag('html4css1', :plugin => 'redmine_restructuredtext_formatter') +
              stylesheet_link_tag('restructuredtext', :plugin => 'redmine_restructuredtext_formatter')
            end
            @heads_for_wiki_formatter_included = true
          end
        end
      end
    end
  end
end
