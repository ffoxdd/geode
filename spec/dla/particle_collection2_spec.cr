require "../spec_helper"

describe DLA::ParticleCollection(Geo::Vector2) do
  it "adds particles to the collection and returns information about them" do
    collection = DLA::ParticleCollection(Geo::Vector2).new

    collection << Geo::Particle(Geo::Vector2).new(
      center: Geo::Vector2.new({-1.0, -1.0}), radius: 1.0
    )

    collection << Geo::Particle(Geo::Vector2).new(
      center: Geo::Vector2.new({1.0, 1.0}), radius: 1.0
    )

    collection.size.should eq(2)

    collection.aabb.should eq(
      Geo::AABB(Geo::Vector2).new(
        minimum_point: Geo::Vector2.new({-2.0, -2.0}),
        maximum_point: Geo::Vector2.new({2.0, 2.0}),
      )
    )

    collection.radius.should be_close(2.414213, 1e-5)
  end

  it "can be initialized with starting particles" do
    collection = DLA::ParticleCollection(Geo::Vector2).new(
      particles: [
        Geo::Particle(Geo::Vector2).new(center: Geo::Vector2.new({3.0, 3.0}), radius: 2.0)
      ]
    )

    collection.size.should eq(1)

    collection.aabb.should eq(
      Geo::AABB(Geo::Vector2).new(
        minimum_point: Geo::Vector2.new({1.0, 1.0}),
        maximum_point: Geo::Vector2.new({5.0, 5.0}),
      )
    )
  end

  it "can iterate over the particles" do
    particles = [
      Geo::Particle(Geo::Vector2).new(center: Geo::Vector2.new({1.0, 1.0}), radius: 1.0),
      Geo::Particle(Geo::Vector2).new(center: Geo::Vector2.new({2.0, 2.0}), radius: 2.0),
    ]

    collection = DLA::ParticleCollection(Geo::Vector2).new(particles: particles)

    yielded_particles(collection).should eq(particles)
  end

  describe "#closest" do
    it "returns the closest particle to the test particle" do
      particles = [
        Geo::Particle(Geo::Vector2).new(center: Geo::Vector2.new({1.0, 1.0}), radius: 1.0),
        Geo::Particle(Geo::Vector2).new(center: Geo::Vector2.new({2.0, 2.0}), radius: 2.0),
      ]

      collection = DLA::ParticleCollection(Geo::Vector2).new(particles: particles)

      test_particle = Geo::Particle(Geo::Vector2).new(center: Geo::Vector2.new({-1.0, -1.0}), radius: 1.0)

      collection.closest(test_particle).should eq(particles[0])
    end
  end
end

def yielded_particles(collection : DLA::ParticleCollection(Geo::Vector2))
  result = [] of Geo::Particle(Geo::Vector2)
  collection.each { |particle| result << particle }
  result
end
