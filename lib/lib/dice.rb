class Dice
  
  attr_accessor :num_of_dice, :sides
  
  @@max_dice = nil
  @@max_sides = nil
  
  
  def initialize(num_of_dice,sides, options={})
    options = filter_options(options)
    raise ArgumentError, "Your sides exceeds the maximum number of sides allowed" if @@max_sides && sides > @@max_sides
    raise ArgumentError, "Your dice exceeds the maximum dice allowed" if @@max_dice && num_of_dice > @@max_dice
    @num_of_dice = num_of_dice
    @sides = sides
  end
  
  def results
    return @results.inject {|sum,x| sum+=x} if @results
    @results = []
    @num_of_dice.times do
      @results << rand(sides) + 1
    end
    return @results.inject {|sum,x| sum+=x}
  end
  
  def reroll
    @results = nil
    return results
  end
  
  # Parses a dice string and returns a dice object
  # More documentation to come later
  
  def self.parse(string)
    dice_regex = /(?<num_of_dice>\d*)d(?<num_of_sides>\d+)/
    dice = dice_regex.match(string)
    raise ArgumentError, "unable to parse dice string" if dice.nil?
    num_of_dice = dice[:num_of_dice].to_i
    num_of_dice = 1 if num_of_dice == 0
    num_of_sides = dice[:num_of_sides].to_i
    dice = Dice.new(num_of_dice,num_of_sides)
    return dice
  end
  
  def self.max_dice=( value )
    @@max_dice = value
  end
  
  def self.max_sides=( value )
    @@max_sides = value
  end
  
  private
  
  def filter_options(options)
    defaults = {:highest=>nil}
    options.each do |key,vale|
      raise ArgumentError, "#{key} is not a valid option" unless defaults.has_key? key
    end
    return defaults.merge(options)
  end
  
end
