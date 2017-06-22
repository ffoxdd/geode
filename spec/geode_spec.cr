require "./spec_helper"
require "../src/geode"

describe Geode do
  describe "VERSION" do
    it "returns the version string" do
      Geode::VERSION.should eq("0.1.0")
    end
  end
end
