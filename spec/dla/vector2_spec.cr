require "../spec_helper"

require "benchmark"

describe DLA::Vector2 do
  describe ".new" do
    it "defaults x and y to 0" do
      vector = DLA::Vector2.new
      vector.should eq(DLA::Vector2.new({0.0, 0.0}))
    end

    it "lets you specify x and y" do
      vector = DLA::Vector2.new({1.0, 2.0})
      vector.should eq(DLA::Vector2.new({1.0, 2.0}))
    end
  end

  describe ".random" do
    it "builds a random point around the origin" do
      vector = DLA::Vector2.random(3.0)
      vector.magnitude.should be_close(3.0, 1.0e-10)
    end
  end

  describe "comparison operators" do
    describe "#<" do
      it "returns true if both components are < than the rhs components" do
        (DLA::Vector2.new({1.0, 2.0}) < DLA::Vector2.new({2.0, 2.0})).should eq(false)
        (DLA::Vector2.new({2.0, 1.0}) < DLA::Vector2.new({2.0, 2.0})).should eq(false)
        (DLA::Vector2.new({2.0, 2.0}) < DLA::Vector2.new({2.0, 2.0})).should eq(false)

        (DLA::Vector2.new({1.0, 1.0}) < DLA::Vector2.new({2.0, 2.0})).should eq(true)
      end
    end

    describe "#>" do
      it "returns true if both components are < than the rhs components" do
        (DLA::Vector2.new({3.0, 2.0}) > DLA::Vector2.new({2.0, 2.0})).should eq(false)
        (DLA::Vector2.new({2.0, 3.0}) > DLA::Vector2.new({2.0, 2.0})).should eq(false)
        (DLA::Vector2.new({2.0, 2.0}) > DLA::Vector2.new({2.0, 2.0})).should eq(false)

        (DLA::Vector2.new({3.0, 3.0}) > DLA::Vector2.new({2.0, 2.0})).should eq(true)
      end
    end

    describe "#<=" do
      it "returns true if both components are < than the rhs components" do
        (DLA::Vector2.new({1.0, 3.0}) <= DLA::Vector2.new({2.0, 2.0})).should eq(false)
        (DLA::Vector2.new({3.0, 1.0}) <= DLA::Vector2.new({2.0, 2.0})).should eq(false)
        (DLA::Vector2.new({3.0, 3.0}) <= DLA::Vector2.new({2.0, 2.0})).should eq(false)

        (DLA::Vector2.new({1.0, 2.0}) <= DLA::Vector2.new({2.0, 2.0})).should eq(true)
        (DLA::Vector2.new({2.0, 1.0}) <= DLA::Vector2.new({2.0, 2.0})).should eq(true)
        (DLA::Vector2.new({2.0, 2.0}) <= DLA::Vector2.new({2.0, 2.0})).should eq(true)
        (DLA::Vector2.new({1.0, 1.0}) <= DLA::Vector2.new({2.0, 2.0})).should eq(true)
      end
    end

    describe "#>=" do
      it "returns true if both components are < than the rhs components" do
        (DLA::Vector2.new({3.0, 1.0}) >= DLA::Vector2.new({2.0, 2.0})).should eq(false)
        (DLA::Vector2.new({1.0, 3.0}) >= DLA::Vector2.new({2.0, 2.0})).should eq(false)
        (DLA::Vector2.new({1.0, 1.0}) >= DLA::Vector2.new({2.0, 2.0})).should eq(false)

        (DLA::Vector2.new({3.0, 2.0}) >= DLA::Vector2.new({2.0, 2.0})).should eq(true)
        (DLA::Vector2.new({2.0, 3.0}) >= DLA::Vector2.new({2.0, 2.0})).should eq(true)
        (DLA::Vector2.new({2.0, 2.0}) >= DLA::Vector2.new({2.0, 2.0})).should eq(true)
        (DLA::Vector2.new({3.0, 3.0}) >= DLA::Vector2.new({2.0, 2.0})).should eq(true)
      end
    end
  end

  describe "#min" do
    it "returns a vector that has the minimum of each component" do
      vector_0 = DLA::Vector2.new({-1.0, 2.0})
      vector_1 = DLA::Vector2.new({3.0, -4.0})

      vector_0.min(vector_1).should eq(DLA::Vector2.new({-1.0, -4.0}))
    end
  end

  describe "#max" do
    it "returns a vector that has the maximum of each component" do
      vector_0 = DLA::Vector2.new({-1.0, 2.0})
      vector_1 = DLA::Vector2.new({3.0, -4.0})

      vector_0.max(vector_1).should eq(DLA::Vector2.new({3.0, 2.0}))
    end
  end

  describe "#magnitude" do
    it "returns the magnitude of the vector" do
      vector = DLA::Vector2.new({3.0, 4.0})
      vector.magnitude.should(eq(5.0))
    end
  end

  describe "#+/-" do
    it "adds/subtracts vectors" do
      vector_1 = DLA::Vector2.new({-3.0, 4.0})
      vector_2 = DLA::Vector2.new({8.0, 1.0})

      (vector_1 + vector_2).should eq(DLA::Vector2.new({5.0, 5.0}))
      (vector_1 - vector_2).should eq(DLA::Vector2.new({-11.0, 3.0}))
    end

    it "adds/subtracts scalars" do
      vector = DLA::Vector2.new({1.0, 2.0})

      (vector + 3.0).should eq(DLA::Vector2.new({4.0, 5.0}))
      (vector - 2.0).should eq(DLA::Vector2.new({-1.0, 0.0}))
    end
  end

  describe "#*/" do
    it "performs scalar multiplication and division" do
      vector = DLA::Vector2.new({2.0, -4.0})

      (vector * 3.0).should eq(DLA::Vector2.new({6.0, -12.0}))
      (vector / 2.0).should eq(DLA::Vector2.new({1.0, -2.0}))
    end
  end
end
