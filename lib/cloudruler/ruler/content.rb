require 'cloudruler/ruler/content/metadata'
require 'cloudruler/ruler/content/parameters'
require 'cloudruler/ruler/content/mappings'
require 'cloudruler/ruler/content/conditions'
require 'cloudruler/ruler/content/transform'
require 'cloudruler/ruler/content/resources'
require 'cloudruler/ruler/content/outputs'

module Cloudruler
  class Ruler
    class Content
      VALID_SECTION_KEYS = %w(
        Metadata
        Parameters
        Mappings
        Conditions
        Transform
        Resources
        Outputs
      )

      class << self
        def parse(ruler, raw_content, options)
          annotation = ''
          content = ''
          raw_content.each_line do |line|
            if line.start_with?('#')
              annotation << line.sub(/\A#/, '')
            else
              content << line
            end
          end
          parsed_annotation = parse_annotation(annotation)
          parsed_content = parse_content(ruler, content)
          self.new(ruler, parsed_annotation, parsed_content, options)
        end

        def parse_annotation(annotation)
          YAML.load(annotation)
        end

        def parse_content(ruler, content)
          if ruler.yaml?
            YAML.load(content)
          elsif ruler.json?
            JSON.parse(content)
          else
            raise 'invalid ext'
          end
        end
      end

      attr_reader :metadata, :parameters, :mappings, :conditions, :transform, :resources, :outputs

      def initialize(ruler, annotations, content_hash, options)
        content_hash.each do |k, v|
          next unless VALID_SECTION_KEYS.include?(k)
          instance_variable_set("@#{k.downcase}", self.class.const_get(k).new(ruler, annotations, v, options))
        end
      end
    end
  end
end
