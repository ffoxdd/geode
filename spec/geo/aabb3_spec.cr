require "../spec_helper"

describe Geo::AABB(Geo::Vector3) do
  describe ".new" do
    it "uses default values with no arguments" do
      aabb = Geo::AABB(Geo::Vector3).new

      aabb.should eq(
        Geo::AABB(Geo::Vector3).new(
          minimum_point: Geo::Vector3.new({0.0, 0.0, 0.0}),
          maximum_point: Geo::Vector3.new({0.0, 0.0, 0.0}),
        )
      )
    end
  end

  describe "#covers?" do
    it "returns true for points inside the box" do
      aabb = Geo::AABB(Geo::Vector3).new(
        minimum_point: Geo::Vector3.new({0.0, 0.0, 0.0}),
        maximum_point: Geo::Vector3.new({2.0, 2.0, 2.0}),
      )

      aabb.covers?(Geo::Vector3.new({-1.0, 1.0, 0.0})).should eq(false)
      aabb.covers?(Geo::Vector3.new({3.0, 1.0, 0.0})).should eq(false)
      aabb.covers?(Geo::Vector3.new({1.0, -1.0, 0.0})).should eq(false)
      aabb.covers?(Geo::Vector3.new({1.0, 3.0, 0.0})).should eq(false)
      aabb.covers?(Geo::Vector3.new({1.0, 1.0, -1.0})).should eq(false)

      aabb.covers?(Geo::Vector3.new({1.0, 1.0, 0.0})).should eq(true)
      aabb.covers?(Geo::Vector3.new({0.0, 0.0, 0.0})).should eq(true)
      aabb.covers?(Geo::Vector3.new({0.0, 2.0, 0.0})).should eq(true)
      aabb.covers?(Geo::Vector3.new({2.0, 0.0, 0.0})).should eq(true)
      aabb.covers?(Geo::Vector3.new({2.0, 2.0, 0.0})).should eq(true)
    end

    it "can take an aabb" do
      aabb = Geo::AABB(Geo::Vector3).new(
        minimum_point: Geo::Vector3.new({0.0, 0.0, 0.0}),
        maximum_point: Geo::Vector3.new({2.0, 2.0, 2.0}),
      )

      aabb.covers?(
        Geo::AABB(Geo::Vector3).new(
          minimum_point: Geo::Vector3.new({1.0, 1.0, 1.0}),
          maximum_point: Geo::Vector3.new({2.0, 2.0, 2.0}),
        )
      ).should eq(true)

      aabb.covers?(
        Geo::AABB(Geo::Vector3).new(
          minimum_point: Geo::Vector3.new({1.0, 1.0, 1.0}),
          maximum_point: Geo::Vector3.new({2.0, 3.0, 2.0}),
        )
      ).should eq(false)
    end
  end

  describe "#union" do
    it "returns the union of the two bounding boxes" do
      aabb_1 = Geo::AABB(Geo::Vector3).new(
        minimum_point: Geo::Vector3.new({2.0, 0.0, -1.0}),
        maximum_point: Geo::Vector3.new({4.0, 4.0, 1.0}),
      )

      aabb_2 = Geo::AABB(Geo::Vector3).new(
        minimum_point: Geo::Vector3.new({1.0, 2.0, -2.0}),
        maximum_point: Geo::Vector3.new({3.0, 6.0, 0.0}),
      )

      aabb_1.union(aabb_2).should eq(
        Geo::AABB(Geo::Vector3).new(
          minimum_point: Geo::Vector3.new({1.0, 0.0, -2.0}),
          maximum_point: Geo::Vector3.new({4.0, 6.0, 1.0}),
        )
      )
    end
  end

  describe "#size" do
    it "returns a vector representing the dimensions of the box" do
      aabb = Geo::AABB(Geo::Vector3).new(
        minimum_point: Geo::Vector3.new({2.0, 0.0, -1.0}),
        maximum_point: Geo::Vector3.new({4.0, 4.0, 2.0}),
      )

      aabb.size.should eq(Geo::Vector3.new({2.0, 4.0, 3.0}))
    end
  end

  describe "#center" do
    it "returns the center point of the box" do
      aabb = Geo::AABB(Geo::Vector3).new(
        minimum_point: Geo::Vector3.new({2.0, 0.0, -3.0}),
        maximum_point: Geo::Vector3.new({4.0, 4.0, -1.0}),
      )

      aabb.center.should eq(Geo::Vector3.new({3.0, 2.0, -2.0}))
    end
  end
end
