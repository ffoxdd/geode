require "../spec_helper"

describe DLA::ParticleCollection(DLA::Vector2) do
  it "adds particles to the collection and returns information about them" do
    collection = DLA::ParticleCollection(DLA::Vector2).new

    collection << DLA::Particle(DLA::Vector2).new(
      center: DLA::Vector2.new({-1.0, -1.0}), radius: 1.0
    )

    collection << DLA::Particle(DLA::Vector2).new(
      center: DLA::Vector2.new({1.0, 1.0}), radius: 1.0
    )

    collection.size.should eq(2)

    collection.aabb.should eq(
      DLA::AABB(DLA::Vector2).new(
        minimum_point: DLA::Vector2.new({-2.0, -2.0}),
        maximum_point: DLA::Vector2.new({2.0, 2.0}),
      )
    )

    collection.radius.should be_close(2.414213, 1e-5)
  end

  it "can be initialized with starting particles" do
    collection = DLA::ParticleCollection(DLA::Vector2).new(
      particles: [
        DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({3.0, 3.0}), radius: 2.0)
      ]
    )

    collection.size.should eq(1)

    collection.aabb.should eq(
      DLA::AABB(DLA::Vector2).new(
        minimum_point: DLA::Vector2.new({1.0, 1.0}),
        maximum_point: DLA::Vector2.new({5.0, 5.0}),
      )
    )
  end

  it "can iterate over the particles" do
    particles = [
      DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({1.0, 1.0}), radius: 1.0),
      DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({2.0, 2.0}), radius: 2.0),
    ]

    collection = DLA::ParticleCollection(DLA::Vector2).new(particles: particles)

    yielded_particles(collection).should eq(particles)
  end

  describe "#closest" do
    it "returns the closest particle to the test particle" do
      particles = [
        DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({1.0, 1.0}), radius: 1.0),
        DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({2.0, 2.0}), radius: 2.0),
      ]

      collection = DLA::ParticleCollection(DLA::Vector2).new(particles: particles)

      test_particle = DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({-1.0, -1.0}), radius: 1.0)

      collection.closest(test_particle).should eq(particles[0])
    end
  end
end

def yielded_particles(collection : DLA::ParticleCollection(DLA::Vector2))
  result = [] of DLA::Particle(DLA::Vector2)
  collection.each { |particle| result << particle }
  result
end
