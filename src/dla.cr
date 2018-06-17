class DLA
  module Grower
    abstract def new_particle()
  end

  getter aabb
  @grower : Grower

  def initialize(particles = [Particle.new], @grower = ::Grower.new)
    @aabb = AABB.new
    @particles = [] of Particle

    particles.each { |particle| add_particle(particle) }
  end

  def size
    @particles.size
  end

  def grow
    add_particle(@grower.new_particle)
  end

  private def add_particle(particle)
    @particles << particle
    @aabb = @aabb.union(particle.aabb)
  end
end
