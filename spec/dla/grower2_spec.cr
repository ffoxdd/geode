require "../spec_helper"

describe DLA::Grower(DLA::Vector2) do
  it "returns a new particle to be added to the aggregate" do
    particles = DLA::ParticleCollection(DLA::Vector2).new(
      particles: [DLA::Particle(DLA::Vector2).new]
    )

    grower = DLA::Grower(DLA::Vector2).new(particle_radius: 1.0, overlap: 0.5)

    new_particle = grower.new_particle(
      particles: particles,
      spawn_radius: 3.0,
      kill_radius: 5.0,
    )

    new_particle.magnitude.should be_close(3.0, 0.5 + 1.0e-10)
  end
end
