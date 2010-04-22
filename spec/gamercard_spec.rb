require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Gamercard do
  it "should raise if the passed template doesn't have a name" do
    lambda{Gamercard.new({})}.should raise_error
  end
  
  it "should have a templater and a template" do
    card = Gamercard.new({'name' => 'basic'})
    card.template.class.name.should == 'Basic'
  end
  
  it "should have template settings" do
    template = Gamercard.new({'name' => 'basic'}).template
    template.settings.should_not be_nil
  end
  
  it "should be able to generate a gamer card" do
    card    = Gamercard.new({'name' => 'basic'})
    card.generate('mattetti').should be_true
  end
  
  it "should respond to save" do
    card    = Gamercard.new({'name' => 'basic'})
    card.generate('mattetti')
    card.should respond_to(:save)
  end
  
  it "should let you save an image" do
    card    = Gamercard.new({'name' => 'basic'})
    card.generate('mattetti')
    card.save
    File.exist?('./mattetti.png').should be_true
    FileUtils.rm('./mattetti.png')
  end
  
  it "should give an IO version of the card" do
    card    = Gamercard.new({'name' => 'basic'})
    card.generate('mattetti')
    card.to_io.should be_an_instance_of(StringIO)
  end
  
  it "should return nil if asking for an IO of a not generated card" do
    card    = Gamercard.new({'name' => 'basic'})
    card.to_io.should be_nil
  end
  
end
