require "./spec_helper"

describe DLA do
  describe ".new" do
    it "returns a DLA with a seed particle" do
      dla = DLA.new
      dla.size.should eq(1)
    end
  end

  describe "#aabb" do
    it "initializes to an origin-centered aabb with radius 1" do
      dla = DLA.new

      dla.aabb.should eq(
        AABB.new(
          minimum_point: Vector2.new(-1.0, -1.0),
          maximum_point: Vector2.new(1.0, 1.0)
        )
      )
    end
  end

  # TODO: perform real-life growth checks in an integration test

  describe "#grow" do
    it "adds a particle to the aggregate" do
      dla = DLA.new
      dla.grow

      dla.size.should eq(2)
    end

    it "updates the bounding box" do
        dla = DLA.new(
          grower: FakeGrower.new(
            Particle.new(center: Vector2.new(1.0, 0.0), radius: 1.0)
          )
        )

        dla.grow

        dla.aabb.should eq(
          AABB.new(
            minimum_point: Vector2.new(-1.0, -1.0),
            maximum_point: Vector2.new(2.0, 1.0)
          )
        )
    end
  end
end

class FakeGrower
  include DLA::Grower

  def initialize(@particle : Particle)
  end

  def new_particle
    @particle
  end
end
