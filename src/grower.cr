class Grower
  include DLA::Grower

  def new_particle()
    Particle.new
  end
end
