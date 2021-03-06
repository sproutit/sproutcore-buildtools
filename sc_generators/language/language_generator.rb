require 'sproutcore/generator_helper'

class LanguageGenerator < RubiGen::Base

  include SproutCore::GeneratorHelper

  default_options :author => nil

  attr_reader :name, :client_location

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @name = args.shift
    extract_options
    assign_names!(@name)
  end

  def manifest
    record do |m|
      fp = client_file_path(nil,'js', nil, "#{file_path}.lproj/strings")
      build_client_directories(m, fp)
      m.template 'strings.js', fp
    end
  end

  protected
    def banner
      <<-EOS
Adds a language to a SproutCore project

USAGE: #{$0} #{spec.name} client_name/language_name [ClassName]
EOS
    end

    def add_options!(opts)
      opts.on("-l", '--loc="Location"', String, "Location of build. If not passed, search clients and frameworks dirs", "Default: none") { |options[:loc]| }
    end

    def extract_options
      @client_location = options[:loc]
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end
end
