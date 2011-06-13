require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Dice do
  
  it "should take 2 arguments" do
    @dice = Dice.new(1,2)
    @dice.num_of_dice.should be 1
    @dice.sides.should be 2
  end
  
  it "should accept an optional third hash of arguments" do
    lambda{ @dice = Dice.new(4,6,{:highest=>3}) }.should_not raise_error
  end
  
  it "should raise an argument error if the option does not exist" do
    lambda{ @dice = Dice.new(4,6,{:no_way_this_exists=>3}) }.should raise_error(ArgumentError)
  end
  
  it "should be able to return results" do
    @dice = Dice.new(1,6)
    @dice.results.should be > 0
    @dice.results.should be < 7
  end
  
  it "should not change results" do
    @dice = Dice.new(100,10)
    a = @dice.results
    b = @dice.results
    c = @dice.results
    d = @dice.results
    a.should be b
    a.should be c
    a.should be d
  end
  
  it "should change results on a reroll" do
    @dice = Dice.new(100,10)
    a = @dice.results
    b = @dice.reroll
    a.should_not be b
  end
  
  it "should be able to parse a dice string" do
    @dice = Dice.parse("1d6")
    @dice.should be_an_instance_of(Dice)
    @dice.sides.should be 6
    @dice.num_of_dice.should be 1
  end
  
  it "should assume 1 dice if no number is specified" do
    @dice = Dice.parse("d6")
    @dice.num_of_dice.should be 1
    @dice.sides.should be 6
  end
  
  it "should raise an error if it can't parse the dice" do
    lambda{ @dice = Dice.parse("1d")}.should raise_error
  end
  
  describe "Max Values" do
    
    it "should throw an error if number of dice exceeds max dice" do
      Dice.max_dice = 1000
      lambda{ Dice.new(1001,6) }.should raise_error
    end
    
    it "should throw an error if the sides exceeds the maximum number of sides" do
      Dice.max_sides = 1000
      lambda{ Dice.new(1,1001) }.should raise_error
    end
    
  end

end
