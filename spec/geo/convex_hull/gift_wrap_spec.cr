require "../../spec_helper"

describe Geo::ConvexHull::GiftWrap do
  describe "#hull" do
    it "returns the convex hull of the given points, as a DCEL" do
      points = [
        Geo::Simplices::Point3.from_coordinates({0.0, 0.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({1.0, 0.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({0.0, 1.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({0.0, 0.0, 1.0, 1.0}),
      ]

      gift_wrap = Geo::ConvexHull::GiftWrap.new(points)
      hull = gift_wrap.hull

      hull.values.size.should eq(4)
      hull.vertices.size.should eq(4)
      hull.edges.size.should eq(6)
      hull.faces.size.should eq(4)
    end
  end
end
