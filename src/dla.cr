class DLA
  module Grower
    abstract def new_particle()
  end

  getter aabb
  @grower : Grower

  def initialize(@grower = ::Grower.new)
    @particles = [] of Particle
    @aabb = AABB.new

    add_particle(Particle.new)
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
