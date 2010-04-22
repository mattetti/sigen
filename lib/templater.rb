require_relative 'gamercard'
require_relative 'template'

class Gamercard
  class Templater  
  
    attr_accessor :templates_path, :template
  
    # Pass an optional template path in the option hash to use a custom path.
    def initialize(template_data)
      template_path   = template_data.delete('template_path')
      @templates_path = template_path || File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      @template       = load_template(template_data)
      self
    end
  
    def load_template(template_data)
      name = template_data['name']
      raise 'Your template settings need to include a name entry' if name.nil?
      begin
        require File.join(templates_path, "#{name}")
      rescue LoadError
        raise ::Gamercard::Template::OptionError, "the #{name}.rb template file could not be found in #{templates_path}"
      else
        # find and return template object
        klass_name = name.capitalize
        if Template.const_defined?(klass_name)
          template_klass = Template.const_get(klass_name)
          template_klass.new(template_data)
        else
          raise Template::OptionError, "The #{klass_name} template class was not found"
        end
      end
    end
  end
end
