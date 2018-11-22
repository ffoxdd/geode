require "../../spec_helper"

describe Geo::Triangulation::Point2 do
  describe "#in_polygon?" do
    it "returns true if the point is inside the polygon" do
      v1 = Geo::Triangulation::Point2.new({0.0, 0.0, 1.0})
      v2 = Geo::Triangulation::Point2.new({3.0, 0.0, 1.0})
      v3 = Geo::Triangulation::Point2.new({0.0, 3.0, 1.0})

      test_point = Geo::Triangulation::Point2.new({1.0, 1.0, 1.0})

      test_point.inside_polygon?(v1, v2, v3).should be_true
    end

    it "returns false if the point is outside the polygon" do
      v1 = Geo::Triangulation::Point2.new({0.0, 0.0, 1.0})
      v2 = Geo::Triangulation::Point2.new({3.0, 0.0, 1.0})
      v3 = Geo::Triangulation::Point2.new({0.0, 3.0, 1.0})

      test_point = Geo::Triangulation::Point2.new({3.0, 3.0, 1.0})

      test_point.inside_polygon?(v1, v2, v3).should be_false
    end
  end
end
