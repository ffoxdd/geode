class DLA::ParticleCollection(V)
  include Aggregate::ParticleCollection(V)
  include Enumerable(DLA::Particle(V))

  @aabb : DLA::AABB(V)
  @particles : Array(DLA::Particle(V))
  getter aabb, radius

  def initialize(particles = ([] of DLA::Particle(V)))
    @aabb = DLA::AABB(V).degenerate
    @particles = [] of DLA::Particle(V)
    @radius = 0.0

    particles.each { |particle| self << particle }
  end

  delegate size, each, to: @particles

  def <<(particle : DLA::Particle(V))
    @particles << particle
    @aabb = @aabb.union(particle.aabb)
    @radius = Math.max(@radius, particle.magnitude)
  end

  def closest(test_particle : DLA::Particle(V))
    min_by { |particle| particle.distance(test_particle) }
  end
end
