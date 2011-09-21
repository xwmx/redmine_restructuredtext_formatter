

class RbST
  
  @@executable_path = File.expand_path(File.join(File.dirname(__FILE__), "rst2parts"))
  @@executables = {
    :html  => File.join(@@executable_path, "rst2html.py"),
    :latex => File.join(@@executable_path, "rst2latex.py")
  }
  
  # Takes a string or file path plus any additional options and converts the input.
  def self.convert(*args)
    new(*args).convert
  end
  
  # Print LaTeX-Specific Options, General Docutils Options and reStructuredText Parser Options.
  def self.latex_options
    new.print_options(:latex)
  end
  
  # Print HTML-Specific Options, General Docutils Options and reStructuredText Parser Options.
  def self.html_options
    new.print_options(:html)
  end
  
  # Specify custom executables to use instead of the default rst2latex.py and
  # rst2html.py scripts. Takes a hash with two possible keys, :html and :latex,
  # which should contain a full path to the alternative executable.
  def self.executables=(exec_paths = {})
    if exec_paths.empty? || (exec_paths.keys & [:html, :latex]).empty?
      raise ArgumentError, "Custom executable format must be :html or :latex"
    end
    @@executables = @@executables.merge(exec_paths)
  end
  # Return the executable hash.
  def self.executables; @@executables end
  
  # Takes a string or file path plus any additional options and creates a new converter object.
  def initialize(*args)
    target = args.shift
    @target  = File.exists?(target) ? File.read(target) : target rescue target
    @options = args
  end

  def convert # :nodoc:
    @output_format ||= :html
    execute "python #{@@executables[@output_format]}" + convert_options
  end
  alias_method :to_s, :convert
  
  # Converts the object's input to HTML.
  def to_html(*args)
    @output_format = :html
    @options += args
    convert
  end
  
  # Converts the object's input to LaTeX.
  def to_latex(*args)
    @output_format = :latex
    @options += args
    convert
  end
  
  # Formats and prints the options from the docutils help in the way they'd be specified in RbST: strings, symbols and hashes.
  def print_options(format)
    help = execute("python #{@@executables[format]} --help")
    # non-hyphenated long options to symbols
    help.gsub!(/(\-\-)([A-Za-z0-9]+)([=|\s])/, ':\2\3')
    # hyphenated long options to quoted strings
    help.gsub!(/(\-\-)([\w|\-]+)(\n)?[^$|^=|\]]?/, '\'\2\'\3')
    # equal to hashrocket
    help.gsub!(/\=/, ' => ')
    # hort options to symbols
    help.gsub!(/([^\w])\-(\w)([^\w])/, '\1:\2\1')
    # short options with args get a hashrocket
    help.gsub!(/(:\w) </, '\1 => <')
    puts help
  end
  
protected
  
  def execute(command)
    output = ''
    IO.popen(command, "w+") do |f| 
      f.puts @target 
      f.close_write
      output = f.read
    end
    output
  end

  def convert_options
    @options.inject('') do |string, opt|
      string + if opt.respond_to?(:each_pair)
        convert_opts_with_args(opt)
      else
        opt.to_s.length == 1 ? " -#{opt}" : " --#{opt.to_s.gsub(/_/, '-')}"
      end
    end
  end
  
  def convert_opts_with_args(opt)
    opt.inject('') do |string, (flag, val)|
      flag = flag.to_s.gsub(/_/, '-')
      string + (flag.length == 1 ? " -#{flag} #{val}" : " --#{flag}=#{val}")
    end
  end
end
