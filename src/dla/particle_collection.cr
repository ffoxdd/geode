class DLA::ParticleCollection
  include DLA::Aggregate::ParticleCollection
  include Enumerable(Particle(Vector2))

  @aabb : AABB(Vector2)
  @particles : Array(Particle(Vector2))
  getter aabb, radius

  def initialize(particles = ([] of Particle(Vector2)))
    @aabb = AABB(Vector2).degenerate
    @particles = [] of Particle(Vector2)
    @radius = 0.0

    particles.each { |particle| self << particle }
  end

  delegate size, to: @particles

  def <<(particle : Particle(Vector2))
    @particles << particle
    @aabb = @aabb.union(particle.aabb)
    @radius = Math.max(@radius, particle.magnitude)
  end

  def each
    @particles.each { |particle| yield particle }
  end

  def closest(test_particle : Particle(Vector2))
    min_by { |particle| particle.distance(test_particle) }
  end
end
