require "../spec_helper"

describe DLA::Aggregate do
  describe ".new" do
    it "defaults to a single particle at the origin" do
      dla = DLA::Aggregate.new

      dla.size.should eq(1)

      dla.aabb.should eq(
        AABB.new(
          minimum_point: Vector2.new(-1.0, -1.0),
          maximum_point: Vector2.new(1.0, 1.0),
        )
      )
    end
  end

  describe "#aabb" do
    it "initializes the aabb to match the initial particles" do
      dla = DLA::Aggregate.new(
        particles: [
          Particle.new(center: Vector2.new(1.0, 1.0), radius: 1.0),
          Particle.new(center: Vector2.new(3.0, 3.0), radius: 2.0),
        ]
      )

      dla.aabb.should eq(
        AABB.new(
          minimum_point: Vector2.new(0.0, 0.0),
          maximum_point: Vector2.new(5.0, 5.0),
        )
      )
    end
  end

  # TODO: perform real-life growth checks in an integration test

  describe "#grow" do
    it "adds a particle to the aggregate" do
        dla = DLA::Aggregate.new(
          grower: FakeGrower.new(
            Particle.new(center: Vector2.new(1.0, 0.0), radius: 1.0)
          )
        )

        dla.grow

        dla.size.should eq(2)

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
  include DLA::Aggregate::Grower

  def initialize(@particle : Particle)
  end

  def new_particle
    @particle
  end
end
