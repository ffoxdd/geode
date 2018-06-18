require "./spec_helper"

require "benchmark"

describe Vector2 do
  describe ".new" do
    it "defaults x and y to 0" do
      vector = Vector2.new
      vector.should eq(Vector2.new(0.0, 0.0))
    end

    it "lets you specify x and y" do
      vector = Vector2.new(1.0, 2.0)
      vector.should eq(Vector2.new(1.0, 2.0))
    end
  end

  describe ".random" do
    it "builds a random point around the origin" do
      vector = Vector2.random(3.0)
      vector.magnitude.should be_close(3.0, 1.0e-10)
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

  describe "#magnitude" do
    it "returns the magnitude of the vector" do
      vector = Vector2.new(3.0, 4.0)
      vector.magnitude.should(eq(5.0))
    end
  end

  describe "#+/-" do
    it "adds/subtracts vectors" do
      vector_1 = Vector2.new(-3.0, 4.0)
      vector_2 = Vector2.new(8.0, 1.0)

      (vector_1 + vector_2).should eq(Vector2.new(5.0, 5.0))
      (vector_1 - vector_2).should eq(Vector2.new(-11.0, 3.0))
    end

    it "adds/subtracts scalars" do
      vector = Vector2.new(1.0, 2.0)

      (vector + 3.0).should eq(Vector2.new(4.0, 5.0))
      (vector - 2.0).should eq(Vector2.new(-1.0, 0.0))
    end
  end

  describe "#*/" do
    it "performs scalar multiplication and division" do
      vector = Vector2.new(2.0, -4.0)

      (vector * 3.0).should eq(Vector2.new(6.0, -12.0))
      (vector / 2.0).should eq(Vector2.new(1.0, -2.0))
    end
  end

  describe "#transform" do
    it "applies a scale then an offset to the vector" do
      vector = Vector2.new(2.0, -4.0)

      vector.transform(scale: 2.0, offset: Vector2.new(1.0, 2.0)).should eq(
        Vector2.new(5.0, -6.0)
      )
    end
  end
end
