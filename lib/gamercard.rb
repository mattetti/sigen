require 'rubygems'
require 'RMagick'
require_relative 'templater'


# Gamercard.new.generate({:name => 'basic', :player => 'mattetti')
class Gamercard
  include Magick

  attr_accessor :templater
  
  def initialize(template_data)
    unless template_data.respond_to?(:has_key?) && template_data.has_key?('name')
      raise Template::OptionError, 'make sure your template info has a name key and that the key is a string'
    end
    @templater = Templater.new(template_data)
    
    # @columns      = 600.0
    # @rows         = 100.0
    # @font_color   = 'white'
    # @font         = File.expand_path(File.join(File.dirname(__FILE__), 'fonts', 'Vera.ttf'))
    # @margin       = 10.0
    # @avatar_width = (@rows - @margin)
    # @avatar_x     = (@columns - (@avatar_width + (@margin/2)))
    # @avatar_y     = ((@rows - @avatar_width)/2)
  
  end
  
  # Returns the template object via the templater
  def template
    templater.template
  end
  
  def generate(username, stats={})
    template.generate(username, stats)
  end
  
  def save(path=nil)
    template.save
  end
  
  def to_io
    template.to_io
  end
  
  # def generate(username)
  #   @username = username
  #   @base = render_gradiated_background
  #   insert_avatar
  #   label
  #   last_game
  #   stats
  #   insert_url
  #   @base.write("#{username}.png")
  # end
  
  def insert_avatar(avatar_file=nil)
    if avatar_file
      @avatar        = Image.read('avatar.jpg')[0]
      resized_avatar = @avatar.resize_to_fit(@avatar_width, @avatar_width)
      @base.composite!(resized_avatar, @avatar_x, @avatar_y, OverCompositeOp)
    end
  end
  
  def label
    @d.fill        = @font_color
    @d.font        = @font
    @d.pointsize   = 14.0
    @d.stroke('transparent')
    @d.font_weight = NormalWeight
    @d.gravity     = WestGravity
    @d             = @d.annotate_scaled(@base, @columns, 1.0, @margin, @margin, "MLB10 #{@username}", 1)
  end
  
  def last_game
    @d.fill        = @font_color
    @d.font        = @font
    @d.pointsize   = 8.0
    @d.stroke('transparent')
    @d.font_weight = NormalWeight
    @d.gravity     = WestGravity
    @d             = @d.annotate_scaled(@base, @columns, 1.0, @margin, (@rows/4), "Last Game: #{Time.now.to_s}", 1)
  end
  
  def stats
    @d.fill        = @font_color
    @d.font        = @font
    @d.pointsize   = 8.0
    @d.stroke('transparent')
    @d.font_weight = NormalWeight
    @d.gravity     = WestGravity
    @d             = @d.annotate_scaled(@base, @columns, 1.0, @margin, ((@rows/4)*2), "Stats: 1 | 2 | 3 | 4 | 5 | 6 |\nmore stats on this line", 1)
  end
  
  def insert_url
    @d.fill      = @font_color
    @d.font      = @font
    @d.pointsize = 8.0
    @d.stroke('transparent')
    @d.font_weight = NormalWeight
    @d.gravity     = WestGravity
    @d             = @d.annotate_scaled(@base, @columns, 1.0, @margin, (@rows - @margin), "http://theshowcommunity.com/players/#{@username}", 1)    
  end
  
  # Use with a theme definition method to draw a gradiated background.
   def render_gradiated_background(top_color='#4a465a', bottom_color='black')
     Image.new(@columns, @rows, GradientFill.new(0, 0, 100, 0, top_color, bottom_color))
   end
  
end



# Magick HACK
module Magick
  class Draw
    # Additional method to scale annotation text since Draw.scale doesn't.
    def annotate_scaled(img, width, height, x, y, text, scale)
      scaled_width = (width * scale) >= 1 ? (width * scale) : 1
      scaled_height = (height * scale) >= 1 ? (height * scale) : 1
 
      self.annotate(img, scaled_width, scaled_height, x * scale, y * scale, text)
    end
  end
end # Magick