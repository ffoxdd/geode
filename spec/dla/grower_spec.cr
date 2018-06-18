require "../spec_helper"

describe DLA::Grower do
  it "returns a new particle to be added to the aggregate" do
    particles = DLA::ParticleCollection.new(particles: [Particle2.new])

    grower = DLA::Grower.new(particle_radius: 1.0, overlap: 0.5)

    new_particle = grower.new_particle(
      particles: particles,
      spawn_radius: 3.0,
      kill_radius: 5.0,
    )

    new_particle.magnitude.should be_close(3.0, 0.5 + 1.0e-10)
  end
end
