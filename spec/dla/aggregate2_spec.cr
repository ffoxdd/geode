require "../spec_helper"

describe DLA::Aggregate(Vector2) do
  describe "#initialize" do
    it "can be given existing particles" do
      particle_collection = DLA::ParticleCollection(Vector2).new(
        particles: [
          Particle(Vector2).new(center: Vector2.new({1.0, 1.0}), radius: 1.0),
          Particle(Vector2).new(center: Vector2.new({3.0, 3.0}), radius: 2.0),
        ]
      )

      aggregate = DLA::Aggregate(Vector2).new(particles: particle_collection)

      aggregate.size.should eq(2)

      aggregate.aabb.should eq(
        AABB(Vector2).new(
          minimum_point: Vector2.new({0.0, 0.0}),
          maximum_point: Vector2.new({5.0, 5.0}),
        )
      )

      yielded_particles(aggregate).should eq(
        [
          Particle(Vector2).new(center: Vector2.new({1.0, 1.0}), radius: 1.0),
          Particle(Vector2).new(center: Vector2.new({3.0, 3.0}), radius: 2.0),
        ]
      )
    end
  end

  describe "#grow" do
    it "adds a particle to the aggregate" do
        particle_collection = DLA::ParticleCollection(Vector2).new(
          particles: [Particle(Vector2).new]
        )

        aggregate = DLA::Aggregate(Vector2).new(
          particles: particle_collection,

          grower: FakeGrower.new(
            Particle(Vector2).new(center: Vector2.new({1.0, 0.0}), radius: 1.0)
          ),
        )

        aggregate.grow

        aggregate.size.should eq(2)

        aggregate.aabb.should eq(
          AABB(Vector2).new(
            minimum_point: Vector2.new({-1.0, -1.0}),
            maximum_point: Vector2.new({2.0, 1.0}),
          )
        )
    end
  end
end

class FakeGrower
  include DLA::Aggregate::Grower(Vector2)

  def initialize(@particle : Particle(Vector2))
  end

  def new_particle(particles, spawn_radius, kill_radius)
    @particle
  end
end

def yielded_particles(aggregate)
  result = [] of Particle(Vector2)
  aggregate.each { |particle| result << particle }
  result
end
