require "./spec_helper"

describe DLA do
  describe ".new" do
    it "returns an empty DLA" do
      dla = DLA.new
      dla.size.should eq(0)
    end
  end
end
