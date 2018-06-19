class DLA::ParticleCollection(V)
  include DLA::Aggregate::ParticleCollection(V)
  include Enumerable(Particle(V))

  @aabb : AABB(V)
  @particles : Array(Particle(V))
  getter aabb, radius

  def initialize(particles = ([] of Particle(V)))
    @aabb = AABB(V).degenerate
    @particles = [] of Particle(V)
    @radius = 0.0

    particles.each { |particle| self << particle }
  end

  delegate size, each, to: @particles

  def <<(particle : Particle(V))
    @particles << particle
    @aabb = @aabb.union(particle.aabb)
    @radius = Math.max(@radius, particle.magnitude)
  end

  def closest(test_particle : Particle(V))
    min_by { |particle| particle.distance(test_particle) }
  end
end
