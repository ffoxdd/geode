require "../spec_helper"

describe Geo::AABB(Geo::Vector2) do
  describe ".new" do
    it "uses default values with no arguments" do
      aabb = Geo::AABB(Geo::Vector2).new

      aabb.should eq(
        Geo::AABB(Geo::Vector2).new(
          minimum_point: Geo::Vector2.new({0.0, 0.0}),
          maximum_point: Geo::Vector2.new({0.0, 0.0}),
        )
      )
    end
  end

  describe "#covers?" do
    it "returns true for points inside the box" do
      aabb = Geo::AABB(Geo::Vector2).new(
        minimum_point: Geo::Vector2.new({0.0, 0.0}),
        maximum_point: Geo::Vector2.new({2.0, 2.0}),
      )

      aabb.covers?(Geo::Vector2.new({-1.0, 1.0})).should eq(false)
      aabb.covers?(Geo::Vector2.new({3.0, 1.0})).should eq(false)
      aabb.covers?(Geo::Vector2.new({1.0, -1.0})).should eq(false)
      aabb.covers?(Geo::Vector2.new({1.0, 3.0})).should eq(false)

      aabb.covers?(Geo::Vector2.new({1.0, 1.0})).should eq(true)

      aabb.covers?(Geo::Vector2.new({0.0, 0.0})).should eq(true)
      aabb.covers?(Geo::Vector2.new({0.0, 2.0})).should eq(true)
      aabb.covers?(Geo::Vector2.new({2.0, 0.0})).should eq(true)
      aabb.covers?(Geo::Vector2.new({2.0, 2.0})).should eq(true)
    end

    it "can take an aabb" do
      aabb = Geo::AABB(Geo::Vector2).new(
        minimum_point: Geo::Vector2.new({0.0, 0.0}),
        maximum_point: Geo::Vector2.new({2.0, 2.0}),
      )

      aabb.covers?(
        Geo::AABB(Geo::Vector2).new(
          minimum_point: Geo::Vector2.new({1.0, 1.0}),
          maximum_point: Geo::Vector2.new({2.0, 2.0}),
        )
      ).should eq(true)

      aabb.covers?(
        Geo::AABB(Geo::Vector2).new(
          minimum_point: Geo::Vector2.new({1.0, 1.0}),
          maximum_point: Geo::Vector2.new({2.0, 3.0}),
        )
      ).should eq(false)
    end
  end

  describe "#union" do
    it "returns the union of the two bounding boxes" do
      aabb_0 = Geo::AABB(Geo::Vector2).new(
        minimum_point: Geo::Vector2.new({2.0, 0.0}),
        maximum_point: Geo::Vector2.new({4.0, 4.0}),
      )

      aabb_1 = Geo::AABB(Geo::Vector2).new(
        minimum_point: Geo::Vector2.new({1.0, 2.0}),
        maximum_point: Geo::Vector2.new({3.0, 6.0}),
      )

      aabb_0.union(aabb_1).should eq(
        Geo::AABB(Geo::Vector2).new(
          minimum_point: Geo::Vector2.new({1.0, 0.0}),
          maximum_point: Geo::Vector2.new({4.0, 6.0}),
        )
      )
    end
  end

  describe "#size" do
    it "returns a vector representing the width/height" do
      aabb = Geo::AABB(Geo::Vector2).new(
        minimum_point: Geo::Vector2.new({2.0, 0.0}),
        maximum_point: Geo::Vector2.new({4.0, 4.0}),
      )

      aabb.size.should eq(Geo::Vector2.new({2.0, 4.0}))
    end
  end

  describe "#center" do
    it "returns the center point of the box" do
      aabb = Geo::AABB(Geo::Vector2).new(
        minimum_point: Geo::Vector2.new({2.0, 0.0}),
        maximum_point: Geo::Vector2.new({4.0, 4.0}),
      )

      aabb.center.should eq(Geo::Vector2.new({3.0, 2.0}))
    end
  end
end
