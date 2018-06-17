module DLA
  class Grower
    include DLA::Aggregate::Grower

    def new_particle()
      Particle.new
    end
  end
end
