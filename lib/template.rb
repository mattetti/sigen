# Gamercard::Template basic class, all templates should inherit from this class
class Gamercard
  class Template
    include Magick
    class OptionError < StandardError; end
    
    attr_reader   :passed_settings
    attr_reader   :width, :height, :username, :stats, :generated, :base, :filename
    
    def initialize(settings={})
      @passed_settings = settings
      @generated = false
      process_settings(settings) if self.class.method_defined?(:process_settings)
    end
    
    def self.fonts_path
      File.expand_path(File.join(File.dirname(__FILE__), 'fonts'))
    end
    
    # template helpers inherited by all templates
    
    def save(path=nil)
      file_path = path.nil? ? (filename || 'image.png') : File.join(path, (filename || 'image.png'))
      base.write(file_path)
    end
    
    def to_io
      if @generated
        StringIO.new(base.to_blob{ self.format = 'PNG' })
      else
        nil
      end
    end
    
    def gradient_background(top_color='#4a465a', bottom_color='black')
      Image.new(@columns, @rows, GradientFill.new(0, 0, 100, 0, top_color, bottom_color))
    end
    
  end
end