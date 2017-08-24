module Cloudruler
  class Ruler
    class Content
      class Base
        attr_reader :ruler

        def initialize(ruler, annotations, content_hash, options)
          @ruler = ruler
          @content_hash = content_hash
          @annotations = annotations
          @name_suffix = options[:resource_name_suffix]
        end

        def content
          @content ||= @content_hash.each_with_object({}) do |(k, v), obj|
            obj[build_name(k)] = v
          end
        end

        def build_name(name)
          name
        end
      end
    end
  end
end
