require 'spec_helper'

describe Server do
  describe "model" do
    before(:each) do
      @server = Factory(:server)
    end

    after(:each) do
      @server.destroy
    end

    it "should not be valid if it misses url" do
      @server.api_url = nil
      @server.should_not be_valid 
    end

    it "should not be valid if it misses username" do
      @server.username = nil
      @server.should_not be_valid
    end

    it "should not be valid if it misses password" do
      @server.password = nil
      @server.should_not be_valid
    end

    it "should not be valid if the url does not point to API" do
      @server.api_url = "http://susestudio.com/api/v2"
      @server.should_not be_valid
    end

    it "should display a good message" do
      @server.update_attributes(:api_url => "http://susestudio.com/api/v2")
      @server.errors[:api_url].should include("The API URL path should point to /api/v2/user.")
    end
  end
end
