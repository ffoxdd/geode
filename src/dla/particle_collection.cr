class DLA::ParticleCollection
  include DLA::Aggregate::ParticleCollection
  include Enumerable(Particle)

  @aabb : AABB
  @particles : Array(Particle)
  getter aabb

  def initialize(particles = ([] of Particle))
    @aabb = self.class.degenerate_aabb
    @particles = [] of Particle

    particles.each { |particle| self << particle }
  end

  def <<(particle : Particle)
    @particles << particle
    @aabb = @aabb.union(particle.aabb)
  end

  def each(&block)
    @particles.each { |particle| yield particle }
  end

  def size
    @particles.size
  end

  def closest(test_particle : Particle)
    min_by { |particle| particle.distance(test_particle) }
  end

  def self.degenerate_aabb
    AABB.new(
      minimum_point: self.infinite_point(1),
      maximum_point: infinite_point(-1),
    )
  end

  def self.infinite_point(sign)
    if sign > 0
      Vector2.new(Float64::INFINITY, Float64::INFINITY)
    else
      Vector2.new(-Float64::INFINITY, -Float64::INFINITY)
    end
  end
end
