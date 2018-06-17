class DLA::Grower
  include DLA::Aggregate::Grower

  @particles : DLA::Aggregate::ParticleCollection

  def initialize(@particle_radius = 1.0, @spawn_radius = 10.0,
    @kill_radius = 20.0, @overlap = 0.2)

    @particles = DLA::ParticleCollection.new
    @test_particle = Particle.new
    @closest_particle = Particle.new
  end

  def new_particle(particles : DLA::Aggregate::ParticleCollection)
    @particles = particles

    spawn

    until stuck?
      step
    end

    @test_particle
  end

  private def spawn
    @test_particle = Particle.new.step(@spawn_radius)
    find_closest_particle
  end

  private def step
    @test_particle = @test_particle.step(@overlap) # TODO: improve performance
    find_closest_particle
    spawn if too_far?
  end

  private def find_closest_particle
    @closest_particle = @particles.closest(@test_particle)
  end

  private def closest_distance
    @test_particle.distance(@closest_particle)
  end

  private def stuck?
    closest_distance <= @overlap
  end

  private def too_far?
    @test_particle.magnitude >= @kill_radius
  end
end
