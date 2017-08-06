require "./spec_helper"

describe Geode do
  describe "VERSION" do
    it "returns the version string" do
      Geode::VERSION.should eq("0.1.0")
    end
  end
end
