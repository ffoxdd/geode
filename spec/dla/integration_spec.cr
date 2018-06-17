require "../spec_helper"

describe DLA do
  describe "Basic growth" do
    it "grows particles and adds them to the aggregate" do
      aggregate = DLA::Aggregate.new(
        particles: DLA::ParticleCollection.new(
          particles: [
            Particle.new(center: Vector2.new(0.0, 0.0), radius: 1.0),
          ]
        )
      )

      100.times { aggregate.grow }

      aggregate.aabb.covers?(
        AABB.new(
          minimum_point: Vector2.new(-4.0, -4.0),
          maximum_point: Vector2.new(4.0, 4.0),
        )
      ).should be_true
    end
  end
end
