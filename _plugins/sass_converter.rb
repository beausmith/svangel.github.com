# Sass plugin to convert .sass to .css
module Jekyll
  require 'sass'
  require 'compass'
  class SassConverter < Converter
    safe true
    priority :low

     def matches(ext)
      ext =~ /sass/i
    end

    def output_ext(ext)
      ".css"
    end

    def convert(content)
      begin
        puts "Performing Sass Conversion."

        Compass.add_project_configuration
        Compass.configuration.project_path ||= Dir.pwd

        load_paths = [".", "./css"]
        load_paths += Compass.configuration.sass_load_paths

        engine = Sass::Engine.new(content, :syntax => :sass, :load_paths => load_paths, :style => :compact)
        engine.render
      rescue StandardError => e
        puts "!!! SASS Error: " + e.message
      end
    end
  end
end