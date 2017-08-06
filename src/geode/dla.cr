class DLA
  def initialize
    @particles = [Particle.new]
  end

  def size
    @particles.size
  end

  def grow
    @particles << Particle.new
  end
end
