require 'json'
require 'yaml'
require 'cloudruler/ruler/content'

module Cloudruler
  class Ruler
    def initialize(path)
      @path = path
    end

    def resolve(options, &block)
      context = EvalContext.new
      context.instance_eval(&block)
      Content.parse(self, context.result(self), options)
    end

    def name
      @name ||= File.basename(@path).sub(/(\A[^\.]+).*/, '\1').to_sym
    end

    def erb
      @erb ||= ERB.new(File.read(@path))
    end

    def ext
      @ext ||= File.extname(@path.sub(/\.erb\z/, '')).sub('.', '')
    end

    def yaml?
      %w(yml yaml).include?(ext)
    end

    def json?
      ext == 'json'
    end

    private

    class EvalContext
      def result(ruler)
        ruler.erb.result(binding)
      end
    end
  end
end
