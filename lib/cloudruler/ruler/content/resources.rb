require 'cloudruler/ruler/content/base'

module Cloudruler
  class Ruler
    class Content
      class Resources < Base
        private

        def build_name(name)
          "#{name}#{@name_suffix}"
        end

        def method_missing(name, *args, &block)
          return build_name(@annotations[name.to_s]) if @annotations[name.to_s]
          super
        end

        def respond_to_missing?(name, include_private = false)
          @annotations.has_key?(name.to_s) || super
        end
      end
    end
  end
end
