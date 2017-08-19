class DLA
  getter aabb

  def initialize
    @particles = [] of Particle
    @aabb = AABB.new

    add_particle(Particle.new)
  end

  def size
    @particles.size
  end

  def grow
    Particle.new.tap { |particle| add_particle(particle) }
  end

  private def add_particle(particle)
    @particles << particle
    @aabb = @aabb.union(particle.aabb)
  end
end
