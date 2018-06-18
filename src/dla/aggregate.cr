class DLA::Aggregate
  module Grower
    abstract def new_particle(particles : ParticleCollection)
  end

  module ParticleCollection
    abstract def <<(particle : Particle)
    abstract def size
    abstract def each(&block : Particle -> _)
    abstract def closest(particle : Particle)
  end

  @particles : ParticleCollection
  @grower : Grower

  getter aabb

  def initialize(@particles = default_particle_collection, @grower = DLA::Grower.new)
  end

  def size
    @particles.size
  end

  def aabb
    @particles.aabb
  end

  def grow
    @particles << @grower.new_particle(@particles)
  end

  private def default_particle_collection
    DLA::ParticleCollection.new(particles: [Particle.new])
  end
end
