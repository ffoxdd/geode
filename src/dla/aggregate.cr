class DLA::Aggregate
  module Grower
    abstract def new_particle(particles : ParticleCollection, spawn_radius, kill_radius)
  end

  module ParticleCollection
    abstract def <<(particle : Particle(Vector2))
    abstract def size
    abstract def each(&block : Particle -> _)
    abstract def closest(particle : Particle(Vector2))
    abstract def radius
  end

  @particles : ParticleCollection
  @grower : Grower

  def initialize(@particles = default_particle_collection, @grower = DLA::Grower.new)
  end

  delegate size, aabb, each, to: @particles

  def grow
    @particles << @grower.new_particle(
      particles: @particles,
      spawn_radius: @particles.radius * 2,
      kill_radius: @particles.radius * 10,
    )
  end

  private def default_particle_collection
    DLA::ParticleCollection.new(particles: [Particle(Vector2).new])
  end
end
