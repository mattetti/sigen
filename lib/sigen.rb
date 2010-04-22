require_relative 'gamercard'

require 'fileutils'
class Sigen
  @queue = :signatures
  @default_save_dir = '/tmp/sigen/signatures'
    
  # location when the signatures will be saved
  def self.save_dir
    if @save_dir
      @save_dir 
    else
      self.save_dir = @default_save_dir
    end
  end
  
  def self.save_dir=(path)
    @save_dir = path
    FileUtils.mkdir_p(@save_dir) unless File.exist?(@save_dir)
    @save_dir
  end
  
  # Creates a gamer card signature and saves it in `save_dir`
  # which points to '/tmp/sigen/signatures' by default.
  #
  # ==== Parameters
  # username<~to_s>:: Username of the player, used to fetch avatar and save the signature.
  # stats<Hash>:: The stats used in the template. The template will look for the stats using hash keys.
  # template<Hash>:: Template info used to generate the signature. Keys are expected to be strings and not symbols.
  #   Only the name key is required. Keys are expected to be strings and not symbols.
  # output_path<String>:: Optional path ti save the output signature.
  #   If not passed, the `save_dir` value will be used.
  #
  # ==== Returns
  # Boolean:: reports the success of the signature creation.
  #
  # ==== Examples
  # Sigen.perform('mattetti', 
  #                   {'rank' => 123, 'team' => 'Cubs', 'last_win' => '2010-04-27'}, 
  #                   {:name => 'mlb10', :style => 'Cubs'})
  #
  # Sigen.perform('mattetti', 
  #                   {'rank' => 123, 'team' => 'Cubs', 'last_win' => '2010-04-27'}, 
  #                   {:name => 'mlb10', :style => 'Cubs'},
  #                   '/tmp/mlb10')
  #
  def self.perform(username, stats, template, output_path=nil)
    card = GamerCard.new(template)
    card.generate(username, stats)
    # path = output_path.nil? ? save_dir : output_path
    # card.save(path)
  end
  
end