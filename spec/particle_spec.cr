require "./spec_helper"

describe Particle do
  describe ".new" do
    it "returns a particle with radius 1" do
      particle = Particle.new
      particle.radius.should eq(1)
    end
  end
end
