class DLA::ParticleCollection
  include DLA::Aggregate::ParticleCollection
  include Enumerable(Particle2)

  @aabb : AABB
  @particles : Array(Particle2)
  getter aabb, radius

  def initialize(particles = ([] of Particle2))
    @aabb = AABB.degenerate
    @particles = [] of Particle2
    @radius = 0.0

    particles.each { |particle| self << particle }
  end

  delegate size, to: @particles

  def <<(particle : Particle2)
    @particles << particle
    @aabb = @aabb.union(particle.aabb)
    @radius = Math.max(@radius, particle.magnitude)
  end

  def each(&block)
    @particles.each { |particle| yield particle }
  end

  def closest(test_particle : Particle2)
    min_by { |particle| particle.distance(test_particle) }
  end
end
