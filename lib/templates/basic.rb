class Basic < Gamercard::Template
  
  
  # The super class already defined the following accessors:
  # :width, :height, :username, :stats, :generated, :base, :filename
  
  # method getting called when a new instance is initiated
  # it's called directly from within initialize
  def process_settings(passed_settings={})
    # we could do something with the passed_settings but in this template
    # only the default settings are used
    @columns = @width  = 600.0
    @rows    = @height = 100.0
    @font_color   = 'white'
    @font         = 'Vera.ttf'
    @margin       = 10.0
    @avatar_width = (@rows - @margin)
    @avatar_x     = (@columns - (@avatar_width + (@margin/2)))
    @avatar_y     = ((@rows - @avatar_width)/2)
  end
  
  def settings
    {
      :width        => @columns,
      :height       => @rows,
      :font_color   => @font_color,
      :font         => @font,
      :margin       => @margin,
      :avatar_width => @avatar_width,
      :avatar_x     => @avatar_x,
      :avatar_y     => @avatar_y,
      :class_name   => self.class.name 
    }
  end
  
  def username_font
    File.join(::Gamercard::Template.fonts_path, @font)
  end
  
  # Returns an image
  def generate(username, stats={})
    @username = username
    @filename = "#{username}.png"
    @stats = stats
    @d = Draw.new
    @base = gradient_background # uses the template helper with default values
    username_label
    @generated = true
  end
  
  def username_label
    @d.fill        = @font_color
    @d.font        = username_font
    @d.pointsize   = 14.0
    @d.stroke('transparent')
    @d.font_weight = NormalWeight
    @d.gravity     = WestGravity
    @d             = @d.annotate_scaled(@base, @columns, 1.0, @margin, @margin, "#{@username}", 1)
  end
  
end