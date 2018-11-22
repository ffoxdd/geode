require "../spec_helper"

describe DLA::Particle(DLA::Vector2) do
  describe ".new" do
    it "returns a particle at the origin with radius 1" do
      DLA::Particle(DLA::Vector2).new.should eq(
        DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({0.0, 0.0}), radius: 1.0)
      )
    end
  end

  describe "#center" do
    it "exposes the center point" do
      center = DLA::Vector2.new({1.0, 2.0})
      particle = DLA::Particle(DLA::Vector2).new(center: center)
      particle.center.should eq(center)
    end
  end

  describe "#magnitude" do
    it "returns the magnitude of the center point plus the radius" do
      particle = DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({3.0, 4.0}), radius: 1.0)
      particle.magnitude.should eq(6.0)
    end
  end

  describe "#aabb" do
    it "returns the aabb that covers the particle" do
      particle = DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({1.0, 2.0}), radius: 2.0)

      particle.aabb.should eq(
        DLA::AABB(DLA::Vector2).new(
          minimum_point: DLA::Vector2.new({-1.0, 0.0}),
          maximum_point: DLA::Vector2.new({3.0, 4.0})
        )
      )
    end
  end

  describe "#step" do
    it "returns a particle moved the given amount in a random direction" do
      particle = DLA::Particle(DLA::Vector2).new
      stepped_particle = particle.step(3.0)

      stepped_particle.magnitude.should be_close(4.0, 1.0e-10)
    end
  end

  describe "#distance" do
    it "returns the distance to the other particle" do
      particle_1 = DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({0.0, 0.0}), radius: 1.0)
      particle_2 = DLA::Particle(DLA::Vector2).new(center: DLA::Vector2.new({5.0, 0.0}), radius: 1.0)

      particle_1.distance(particle_2).should be_close(3.0, 1.0e-10)
    end
  end
end
