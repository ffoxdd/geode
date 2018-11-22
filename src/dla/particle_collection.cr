require "../geo/particle"

class DLA::ParticleCollection(V)
  include Aggregate::ParticleCollection(V)
  include Enumerable(Geo::Particle(V))

  @aabb : Geo::AABB(V)
  @particles : Array(Geo::Particle(V))
  getter aabb, radius

  def initialize(particles = ([] of Geo::Particle(V)))
    @aabb = Geo::AABB(V).degenerate
    @particles = [] of Geo::Particle(V)
    @radius = 0.0

    particles.each { |particle| self << particle }
  end

  delegate size, each, to: @particles

  def <<(particle : Geo::Particle(V))
    @particles << particle
    @aabb = @aabb.union(particle.aabb)
    @radius = Math.max(@radius, particle.magnitude)
  end

  def closest(test_particle : Geo::Particle(V))
    min_by { |particle| particle.distance(test_particle) }
  end
end
