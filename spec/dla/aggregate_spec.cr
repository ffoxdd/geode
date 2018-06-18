require "../spec_helper"

describe DLA::Aggregate do
  describe "#initialize" do
    it "can be given existing particles" do
      aggregate = DLA::Aggregate.new(
        particles: DLA::ParticleCollection.new(
          particles: [
            Particle.new(center: Vector2.new(1.0, 1.0), radius: 1.0),
            Particle.new(center: Vector2.new(3.0, 3.0), radius: 2.0),
          ]
        )
      )

      aggregate.size.should eq(2)

      aggregate.aabb.should eq(
        AABB.new(
          minimum_point: Vector2.new(0.0, 0.0),
          maximum_point: Vector2.new(5.0, 5.0),
        )
      )

      yielded_particles(aggregate).should eq(
        [
          Particle.new(center: Vector2.new(1.0, 1.0), radius: 1.0),
          Particle.new(center: Vector2.new(3.0, 3.0), radius: 2.0),
        ]
      )
    end
  end

  describe "#grow" do
    it "adds a particle to the aggregate" do
        aggregate = DLA::Aggregate.new(
          particles: DLA::ParticleCollection.new(particles: [Particle.new]),

          grower: FakeGrower.new(
            Particle.new(center: Vector2.new(1.0, 0.0), radius: 1.0)
          ),
        )

        aggregate.grow

        aggregate.size.should eq(2)

        aggregate.aabb.should eq(
          AABB.new(
            minimum_point: Vector2.new(-1.0, -1.0),
            maximum_point: Vector2.new(2.0, 1.0),
          )
        )
    end
  end
end

class FakeGrower
  include DLA::Aggregate::Grower

  def initialize(@particle : Particle)
  end

  def new_particle(particles, spawn_radius, kill_radius)
    @particle
  end
end

def yielded_particles(aggregate)
  result = [] of Particle
  aggregate.each { |particle| result << particle }
  result
end
