require "./spec_helper"

describe DLA do
  describe ".new" do
    it "returns a DLA with a seed particle" do
      dla = DLA.new
      dla.size.should eq(1)
    end
  end

  describe "#grow" do
    it "adds a particle to the aggregate" do
      dla = DLA.new
      dla.grow

      dla.size.should eq(2)
    end
  end
end
