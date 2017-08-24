module Cloudruler
  class Template
    DEFAULT_FORMAT_VERSION = '2010-09-09'.freeze

    attr_accessor :rulers, :format_version, :description

    def initialize(runner, path)
      @runner = runner
      @path = path
      @rulers = []
      @format_version = DEFAULT_FORMAT_VERSION
      @description = ''
    end

    def resolve
      @rulers = []
      context = EvalContext.new(self)
      context.instance_eval(body)
      self
    end

    def dump
      result = {
        'AWSTemplateFormatVersion' => @format_version,
        'Description' => @description,
      }
      result['Metadata'] = @rulers.map(&:metadata).compact.map(&:content)
      result['Parameters'] = @rulers.map(&:parameters).compact.map(&:content)
      result['Mappings'] = @rulers.map(&:mappings).compact.map(&:content)
      result['Conditions'] = @rulers.map(&:conditions).compact.map(&:content)
      result['Transform'] = @rulers.map(&:transform).compact.map(&:content)
      result['Resources'] = @rulers.map(&:resources).compact.map(&:content)
      result['Outputs'] = @rulers.map(&:outputs).compact.map(&:content)
      result = result.reject { |_, v| v.empty? }.each_with_object({}) do |(k, v), obj|
        v.respond_to?(:reduce) ? obj[k] = v.reduce(&:merge) : obj[k] = v
      end
      result.to_yaml
    end

    def body
      @body ||= File.read(@path)
    end

    def resolve_ruler(ruler_name, options, &block)
      ruler = @runner.find_ruler(ruler_name)
      ruler.resolve(options, &block)
    end

    class EvalContext
      def initialize(template)
        @template = template
      end

      def ruler(ruler_name, options = {}, &block)
        resolved_ruler = @template.resolve_ruler(ruler_name, options, &block)
        @template.rulers << resolved_ruler
        resolved_ruler
      end

      def format_version(format_version)
        @template.format_version = format_version
      end

      def description(description)
        @template.description = description
      end
    end
  end
end
