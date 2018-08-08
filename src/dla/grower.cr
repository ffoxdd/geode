class DLA::Grower(V)
  include DLA::Aggregate::Grower(V)

  def initialize(@particle_radius = 1.0, @overlap = 0.2)
  end

  def new_particle(particles, spawn_radius, kill_radius)
    Context(V).new(
      particles: particles,
      particle_radius: @particle_radius,
      spawn_radius: spawn_radius,
      kill_radius: kill_radius,
      overlap: @overlap,
    ).new_particle
  end

  class Context(V)
    @particles : DLA::Aggregate::ParticleCollection(V)

    def initialize(@particles, @particle_radius = 1.0, @spawn_radius = 10.0,
      @kill_radius = 20.0, @overlap = 0.2)

      @test_particle = Geo::Particle(V).new
      @closest_particle = Geo::Particle(V).new
    end

    def new_particle
      spawn

      until stuck?
        step
      end

      @test_particle
    end

    private def spawn
      @test_particle = Geo::Particle(V).new.step(@spawn_radius)
      find_closest_particle
    end

    private def step
      @test_particle = @test_particle.step(step_distance)
      find_closest_particle
      spawn if too_far?
    end

    private def step_distance
      closest_distance + @overlap
    end

    private def find_closest_particle
      @closest_particle = @particles.closest(@test_particle)
    end

    private def closest_distance
      @test_particle.distance(@closest_particle)
    end

    private def stuck?
      closest_distance <= 0
    end

    private def too_far?
      @test_particle.magnitude >= @kill_radius
    end
  end
end
