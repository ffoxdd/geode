require "./spec_helper"

describe Particle do
  describe ".new" do
    it "returns a particle at the origin with radius 1" do
      particle = Particle.new

      particle.should eq(
        Particle.new(
          center: Vector2.new(0.0, 0.0),
          radius: 1.0
        )
      )
    end
  end

  describe "#x/#y" do
    it "delegates x and y to the center point" do
      particle = Particle.new(center: Vector2.new(1.0, 2.0))

      particle.x.should eq(1.0)
      particle.y.should eq(2.0)
    end
  end

  describe "#magnitude" do
    it "delegates magnitude to the center point" do
      particle = Particle.new(center: Vector2.new(3.0, 4.0))
      particle.magnitude.should eq(5.0)
    end
  end

  describe "#aabb" do
    it "returns the aabb that covers the particle" do
      particle = Particle.new(center: Vector2.new(1.0, 2.0), radius: 2.0)

      particle.aabb.should eq(
        AABB.new(
          minimum_point: Vector2.new(-1.0, 0.0),
          maximum_point: Vector2.new(3.0, 4.0)
        )
      )
    end
  end

  describe "#step" do
    it "returns a particle moved the given amount in a random direction" do
      particle = Particle.new
      stepped_particle = particle.step(3.0)

      stepped_particle.magnitude.should be_close(3.0, 1.0e-10)
    end
  end

  describe "#distance" do
    it "returns the distance to the other particle" do
      particle_1 = Particle.new(center: Vector2.new(0.0, 0.0), radius: 1.0)
      particle_2 = Particle.new(center: Vector2.new(5.0, 0.0), radius: 1.0)

      particle_1.distance(particle_2).should be_close(3.0, 1.0e-10)
    end
  end
end
