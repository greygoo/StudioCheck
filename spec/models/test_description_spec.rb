require 'spec_helper'

describe TestDescription do
  describe "model" do
    before(:each) do
      @test_description = Factory(:test_description)
    end

    it "should not be valid without description" do
      @test_description.description = nil  
      @test_description.should_not be_valid
    end
  end
end
