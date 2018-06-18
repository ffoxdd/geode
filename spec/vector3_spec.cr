require "./spec_helper"

require "benchmark"

describe Vector3 do
  describe ".new" do
    it "defaults to a point at the origin" do
      Vector3.new.should eq(Vector3.new(0.0, 0.0, 0.0))
    end

    it "allows initializing components" do
      Vector3.new(1.0, 2.0, 3.0).should eq(Vector3.new(1.0, 2.0, 3.0))
    end
  end

  pending ".random" do
    it "builds a random point around the origin" do
      # vector = Vector3.random(3.0)
      # vector.magnitude.should be_close(3.0, 1.0e-10)
    end
  end

  describe "comparison operators" do
    describe "#<" do
      it "returns true if all components are < than the rhs components" do
        (Vector3.new(2.0, 1.0, 1.0) < Vector3.new(2.0, 2.0, 2.0)).should eq(false)
        (Vector3.new(1.0, 2.0, 1.0) < Vector3.new(2.0, 2.0, 2.0)).should eq(false)
        (Vector3.new(1.0, 1.0, 2.0) < Vector3.new(2.0, 2.0, 2.0)).should eq(false)
        (Vector3.new(1.0, 1.0, 1.0) < Vector3.new(2.0, 2.0, 2.0)).should eq(true)
      end
    end

    describe "#>" do
      it "returns true if all components are > than the rhs components" do
        (Vector3.new(2.0, 3.0, 3.0) > Vector3.new(2.0, 2.0, 2.0)).should eq(false)
        (Vector3.new(3.0, 2.0, 3.0) > Vector3.new(2.0, 2.0, 2.0)).should eq(false)
        (Vector3.new(3.0, 3.0, 2.0) > Vector3.new(2.0, 2.0, 2.0)).should eq(false)
        (Vector3.new(3.0, 3.0, 3.0) > Vector3.new(2.0, 2.0, 2.0)).should eq(true)
      end
    end

    describe "#<=" do
      it "returns true if all components are < than the rhs components" do
        (Vector3.new(1.0, 1.0, 3.0) <= Vector3.new(2.0, 2.0, 2.0)).should eq(false)
        (Vector3.new(1.0, 1.0, 2.0) <= Vector3.new(2.0, 2.0, 2.0)).should eq(true)
      end
    end

    describe "#>=" do
      it "returns true if all components are < than the rhs components" do
        (Vector3.new(3.0, 3.0, 1.0) >= Vector3.new(2.0, 2.0, 2.0)).should eq(false)
        (Vector3.new(3.0, 3.0, 2.0) >= Vector3.new(2.0, 2.0, 2.0)).should eq(true)
      end
    end
  end

  describe "#min" do
    it "returns a vector that has the minimum of each component" do
      vector_0 = Vector3.new(-1.0, 2.0, 3.0)
      vector_1 = Vector3.new(3.0, -4.0, 2.0)

      vector_0.min(vector_1).should eq(Vector3.new(-1.0, -4.0, 2.0))
    end
  end

  describe "#max" do
    it "returns a vector that has the maximum of each component" do
      vector_0 = Vector3.new(-1.0, 2.0, 3.0)
      vector_1 = Vector3.new(3.0, -4.0, 2.0)

      vector_0.max(vector_1).should eq(Vector3.new(3.0, 2.0, 3.0))
    end
  end

  describe "#magnitude" do
    it "returns the magnitude of the vector" do
      vector = Vector3.new(1.0, 2.0, 3.0)
      vector.magnitude.should be_close(3.74165, 1e-5)
    end
  end

  describe "#+/-" do
    it "adds/subtracts vectors" do
      vector_1 = Vector3.new(-3.0, 4.0, 1.0)
      vector_2 = Vector3.new(8.0, 1.0, 1.0)

      (vector_1 + vector_2).should eq(Vector3.new(5.0, 5.0, 2.0))
      (vector_1 - vector_2).should eq(Vector3.new(-11.0, 3.0, 0.0))
    end

    it "adds/subtracts scalars" do
      vector = Vector3.new(1.0, 2.0, 3.0)

      (vector + 3.0).should eq(Vector3.new(4.0, 5.0, 6.0))
      (vector - 2.0).should eq(Vector3.new(-1.0, 0.0, 1.0))
    end
  end

  describe "#*/" do
    it "performs scalar multiplication and division" do
      vector = Vector3.new(2.0, -4.0, 3.0)

      (vector * 3.0).should eq(Vector3.new(6.0, -12.0, 9.0))
      (vector / 2.0).should eq(Vector3.new(1.0, -2.0, 1.5))
    end
  end
end
