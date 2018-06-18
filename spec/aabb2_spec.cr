require "./spec_helper"

describe AABB(Vector2) do
  describe ".new" do
    it "uses default values with no arguments" do
      aabb = AABB(Vector2).new

      aabb.should eq(
        AABB(Vector2).new(
          minimum_point: Vector2.new(0.0, 0.0),
          maximum_point: Vector2.new(0.0, 0.0),
        )
      )
    end
  end

  describe "#covers?" do
    it "returns true for points inside the box" do
      aabb = AABB(Vector2).new(
        minimum_point: Vector2.new(0.0, 0.0),
        maximum_point: Vector2.new(2.0, 2.0),
      )

      aabb.covers?(Vector2.new(-1.0, 1.0)).should eq(false)
      aabb.covers?(Vector2.new(3.0, 1.0)).should eq(false)
      aabb.covers?(Vector2.new(1.0, -1.0)).should eq(false)
      aabb.covers?(Vector2.new(1.0, 3.0)).should eq(false)

      aabb.covers?(Vector2.new(1.0, 1.0)).should eq(true)

      aabb.covers?(Vector2.new(0.0, 0.0)).should eq(true)
      aabb.covers?(Vector2.new(0.0, 2.0)).should eq(true)
      aabb.covers?(Vector2.new(2.0, 0.0)).should eq(true)
      aabb.covers?(Vector2.new(2.0, 2.0)).should eq(true)
    end

    it "can take an aabb" do
      aabb = AABB(Vector2).new(
        minimum_point: Vector2.new(0.0, 0.0),
        maximum_point: Vector2.new(2.0, 2.0),
      )

      aabb.covers?(
        AABB(Vector2).new(
          minimum_point: Vector2.new(1.0, 1.0),
          maximum_point: Vector2.new(2.0, 2.0),
        )
      ).should eq(true)

      aabb.covers?(
        AABB(Vector2).new(
          minimum_point: Vector2.new(1.0, 1.0),
          maximum_point: Vector2.new(2.0, 3.0),
        )
      ).should eq(false)
    end
  end

  describe "#union" do
    it "returns the union of the two bounding boxes" do
      aabb_0 = AABB(Vector2).new(
        minimum_point: Vector2.new(2.0, 0.0),
        maximum_point: Vector2.new(4.0, 4.0),
      )

      aabb_1 = AABB(Vector2).new(
        minimum_point: Vector2.new(1.0, 2.0),
        maximum_point: Vector2.new(3.0, 6.0),
      )

      aabb_0.union(aabb_1).should eq(
        AABB(Vector2).new(
          minimum_point: Vector2.new(1.0, 0.0),
          maximum_point: Vector2.new(4.0, 6.0),
        )
      )
    end
  end

  describe "#size" do
    it "returns a vector representing the width/height" do
      aabb = AABB(Vector2).new(
        minimum_point: Vector2.new(2.0, 0.0),
        maximum_point: Vector2.new(4.0, 4.0),
      )

      aabb.size.should eq(Vector2.new(2.0, 4.0))
    end
  end

  describe "#center" do
    it "returns the center point of the box" do
      aabb = AABB(Vector2).new(
        minimum_point: Vector2.new(2.0, 0.0),
        maximum_point: Vector2.new(4.0, 4.0),
      )

      aabb.center.should eq(Vector2.new(3.0, 2.0))
    end
  end
end
