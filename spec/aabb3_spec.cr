require "./spec_helper"

describe AABB(Vector3) do
  describe ".new" do
    it "uses default values with no arguments" do
      aabb = AABB(Vector3).new

      aabb.should eq(
        AABB(Vector3).new(
          minimum_point: Vector3.new({0.0, 0.0, 0.0}),
          maximum_point: Vector3.new({0.0, 0.0, 0.0}),
        )
      )
    end
  end

  describe "#covers?" do
    it "returns true for points inside the box" do
      aabb = AABB(Vector3).new(
        minimum_point: Vector3.new({0.0, 0.0, 0.0}),
        maximum_point: Vector3.new({2.0, 2.0, 2.0}),
      )

      aabb.covers?(Vector3.new({-1.0, 1.0, 0.0})).should eq(false)
      aabb.covers?(Vector3.new({3.0, 1.0, 0.0})).should eq(false)
      aabb.covers?(Vector3.new({1.0, -1.0, 0.0})).should eq(false)
      aabb.covers?(Vector3.new({1.0, 3.0, 0.0})).should eq(false)
      aabb.covers?(Vector3.new({1.0, 1.0, -1.0})).should eq(false)

      aabb.covers?(Vector3.new({1.0, 1.0, 0.0})).should eq(true)
      aabb.covers?(Vector3.new({0.0, 0.0, 0.0})).should eq(true)
      aabb.covers?(Vector3.new({0.0, 2.0, 0.0})).should eq(true)
      aabb.covers?(Vector3.new({2.0, 0.0, 0.0})).should eq(true)
      aabb.covers?(Vector3.new({2.0, 2.0, 0.0})).should eq(true)
    end

    it "can take an aabb" do
      aabb = AABB(Vector3).new(
        minimum_point: Vector3.new({0.0, 0.0, 0.0}),
        maximum_point: Vector3.new({2.0, 2.0, 2.0}),
      )

      aabb.covers?(
        AABB(Vector3).new(
          minimum_point: Vector3.new({1.0, 1.0, 1.0}),
          maximum_point: Vector3.new({2.0, 2.0, 2.0}),
        )
      ).should eq(true)

      aabb.covers?(
        AABB(Vector3).new(
          minimum_point: Vector3.new({1.0, 1.0, 1.0}),
          maximum_point: Vector3.new({2.0, 3.0, 2.0}),
        )
      ).should eq(false)
    end
  end

  describe "#union" do
    it "returns the union of the two bounding boxes" do
      aabb_1 = AABB(Vector3).new(
        minimum_point: Vector3.new({2.0, 0.0, -1.0}),
        maximum_point: Vector3.new({4.0, 4.0, 1.0}),
      )

      aabb_2 = AABB(Vector3).new(
        minimum_point: Vector3.new({1.0, 2.0, -2.0}),
        maximum_point: Vector3.new({3.0, 6.0, 0.0}),
      )

      aabb_1.union(aabb_2).should eq(
        AABB(Vector3).new(
          minimum_point: Vector3.new({1.0, 0.0, -2.0}),
          maximum_point: Vector3.new({4.0, 6.0, 1.0}),
        )
      )
    end
  end

  describe "#size" do
    it "returns a vector representing the dimensions of the box" do
      aabb = AABB(Vector3).new(
        minimum_point: Vector3.new({2.0, 0.0, -1.0}),
        maximum_point: Vector3.new({4.0, 4.0, 2.0}),
      )

      aabb.size.should eq(Vector3.new({2.0, 4.0, 3.0}))
    end
  end

  describe "#center" do
    it "returns the center point of the box" do
      aabb = AABB(Vector3).new(
        minimum_point: Vector3.new({2.0, 0.0, -3.0}),
        maximum_point: Vector3.new({4.0, 4.0, -1.0}),
      )

      aabb.center.should eq(Vector3.new({3.0, 2.0, -2.0}))
    end
  end
end
