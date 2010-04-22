$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sigen'
require 'spec'
require 'spec/autorun'
require 'fileutils'

Spec::Runner.configure do |config|
  
end
