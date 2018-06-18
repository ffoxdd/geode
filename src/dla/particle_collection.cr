class DLA::ParticleCollection
  include DLA::Aggregate::ParticleCollection
  include Enumerable(Particle)

  @aabb : AABB
  @particles : Array(Particle)
  getter aabb

  def initialize(particles = ([] of Particle))
    @aabb = AABB.degenerate
    @particles = [] of Particle

    particles.each { |particle| self << particle }
  end

  delegate size, to: @particles

  def <<(particle : Particle)
    @particles << particle
    @aabb = @aabb.union(particle.aabb)
  end

  def each(&block)
    @particles.each { |particle| yield particle }
  end

  def closest(test_particle : Particle)
    min_by { |particle| particle.distance(test_particle) }
  end
end
