class DLA::Aggregate(V)
  module Grower(V)
    abstract def new_particle(particles : ParticleCollection(V),
      spawn_radius, kill_radius)
  end

  module ParticleCollection(V)
    abstract def <<(particle : Geo::Particle(V))
    abstract def size
    abstract def each(&block : Geo::Particle(V) -> _)
    abstract def closest(particle : Geo::Particle(V))
    abstract def radius
  end

  @particles : ParticleCollection(V)
  @grower : Grower(V)

  def initialize(@particles = seed_particle, @grower = DLA::Grower(V).new)
  end

  delegate size, aabb, each, to: @particles

  def grow
    @particles << @grower.new_particle(
      particles: @particles,
      spawn_radius: @particles.radius * 2,
      kill_radius: @particles.radius * 10,
    )
  end

  private def seed_particle
    DLA::ParticleCollection(V).new(particles: [Geo::Particle(V).new])
  end
end
