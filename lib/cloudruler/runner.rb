require 'cloudruler/template'
require 'cloudruler/ruler'

module Cloudruler
  class Runner
    class << self
      def dump(template_file, options = {})
        runner = self.new(template_file, options)
        runner.load_rulers
        runner.dump
      end
    end

    def initialize(template_file, options)
      @template = Template.new(self, File.expand_path(template_file))
      @rulers_root = File.expand_path(options[:rulers_root] || 'rulers', File.join(Dir.pwd))
      @rulers = []
    end

    def load_rulers
      Dir.glob(File.join(@rulers_root, '*')).each do |path|
        next if Dir.exist?(path)
        @rulers << Ruler.new(path)
      end
    end

    def dump
      @template.resolve.dump
    end

    def find_ruler(name)
      name = name.to_sym
      @rulers.find { |ruler| ruler.name == name }
    end
  end
end
