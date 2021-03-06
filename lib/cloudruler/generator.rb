require 'thor'

module Cloudruler
  class Generator < Thor::Group
    include Thor::Actions

    def self.source_root
      File.expand_path('../generator/templates', __FILE__)
    end

    def copy_files
      directory '.'
    end

    def bundle
      inside destination_root do
        run "bundle install"
      end
    end
  end
end
