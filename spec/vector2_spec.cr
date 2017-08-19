require "./spec_helper"

require "benchmark"

describe Vector2 do
  describe "#initialize" do
    it "defaults x and y to 0" do
      vector = Vector2.new
      vector.should eq(Vector2.new(0.0, 0.0))
    end

    it "lets you specify x and y" do
      vector = Vector2.new(1.0, 2.0)
      vector.should eq(Vector2.new(1.0, 2.0))
    end
  end

  describe "comparison operators" do
    describe "#<" do
      it "returns true if both components are < than the rhs components" do
        (Vector2.new(1.0, 2.0) < Vector2.new(2.0, 2.0)).should eq(false)
        (Vector2.new(2.0, 1.0) < Vector2.new(2.0, 2.0)).should eq(false)
        (Vector2.new(2.0, 2.0) < Vector2.new(2.0, 2.0)).should eq(false)

        (Vector2.new(1.0, 1.0) < Vector2.new(2.0, 2.0)).should eq(true)
      end
    end

    describe "#>" do
      it "returns true if both components are < than the rhs components" do
        (Vector2.new(3.0, 2.0) > Vector2.new(2.0, 2.0)).should eq(false)
        (Vector2.new(2.0, 3.0) > Vector2.new(2.0, 2.0)).should eq(false)
        (Vector2.new(2.0, 2.0) > Vector2.new(2.0, 2.0)).should eq(false)

        (Vector2.new(3.0, 3.0) > Vector2.new(2.0, 2.0)).should eq(true)
      end
    end

    describe "#<=" do
      it "returns true if both components are < than the rhs components" do
        (Vector2.new(1.0, 3.0) <= Vector2.new(2.0, 2.0)).should eq(false)
        (Vector2.new(3.0, 1.0) <= Vector2.new(2.0, 2.0)).should eq(false)
        (Vector2.new(3.0, 3.0) <= Vector2.new(2.0, 2.0)).should eq(false)

        (Vector2.new(1.0, 2.0) <= Vector2.new(2.0, 2.0)).should eq(true)
        (Vector2.new(2.0, 1.0) <= Vector2.new(2.0, 2.0)).should eq(true)
        (Vector2.new(2.0, 2.0) <= Vector2.new(2.0, 2.0)).should eq(true)
        (Vector2.new(1.0, 1.0) <= Vector2.new(2.0, 2.0)).should eq(true)
      end
    end

    describe "#>=" do
      it "returns true if both components are < than the rhs components" do
        (Vector2.new(3.0, 1.0) >= Vector2.new(2.0, 2.0)).should eq(false)
        (Vector2.new(1.0, 3.0) >= Vector2.new(2.0, 2.0)).should eq(false)
        (Vector2.new(1.0, 1.0) >= Vector2.new(2.0, 2.0)).should eq(false)

        (Vector2.new(3.0, 2.0) >= Vector2.new(2.0, 2.0)).should eq(true)
        (Vector2.new(2.0, 3.0) >= Vector2.new(2.0, 2.0)).should eq(true)
        (Vector2.new(2.0, 2.0) >= Vector2.new(2.0, 2.0)).should eq(true)
        (Vector2.new(3.0, 3.0) >= Vector2.new(2.0, 2.0)).should eq(true)
      end
    end
  end

  describe "#min" do
    it "returns a vector that has the minimum of each component" do
      vector_0 = Vector2.new(-1.0, 2.0)
      vector_1 = Vector2.new(3.0, -4.0)

      vector_0.min(vector_1).should eq(Vector2.new(-1.0, -4.0))
    end
  end

  describe "#max" do
    it "returns a vector that has the maximum of each component" do
      vector_0 = Vector2.new(-1.0, 2.0)
      vector_1 = Vector2.new(3.0, -4.0)

      vector_0.max(vector_1).should eq(Vector2.new(3.0, 2.0))
    end
  end

end
