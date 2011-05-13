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

      javascript_tag(<<-EOD)
      var textarea = $('#{field_id}');
      var editor = CodeMirror.fromTextArea(textarea, {
          onBlur: function() { editor.save(); },
          lineNumbers: false,
      });
      var toolbar = new jsToolBar(editor, textarea);
      toolbar.setHelpLink('#{help_link}');
      toolbar.draw();
      EOD
    end


    def initial_page_content(page)
      line = '=' * page.pretty_title.mb_chars.length
      "#{line}\n#{page.pretty_title}\n#{line}"
    end

    def heads_for_wiki_formatter
      unless @heads_for_wiki_formatter_included
        content_for :header_tags do
          javascript_include_tag('jstoolbar', :plugin => 'redmine_restructuredtext_formatter') +
          javascript_include_tag('restructuredtext', :plugin => 'redmine_restructuredtext_formatter') +
          javascript_include_tag("jstoolbar/lang/jstoolbar-#{current_language.to_s.downcase}") +
          javascript_include_tag("lang/restructuredtext-#{current_language.to_s.downcase}", :plugin => 'redmine_restructuredtext_formatter') +
          javascript_include_tag("codemirror-#{I18n.t(:direction)}", :plugin => 'redmine_restructuredtext_formatter') +
          javascript_include_tag('codemirror-rst', :plugin => 'redmine_restructuredtext_formatter') +
          stylesheet_link_tag('jstoolbar') +
          stylesheet_link_tag('html4css1', :plugin => 'redmine_restructuredtext_formatter') +
          stylesheet_link_tag('restructuredtext', :plugin => 'redmine_restructuredtext_formatter') +
          stylesheet_link_tag("codemirror-#{I18n.t(:direction)}", :plugin => 'redmine_restructuredtext_formatter') +
          stylesheet_link_tag('codemirror-rst', :plugin => 'redmine_restructuredtext_formatter') +
          '<style>.CodeMirror { border: 1px solid black; }</style>'
        end
        @heads_for_wiki_formatter_included = true
      end
    end
  end
end
