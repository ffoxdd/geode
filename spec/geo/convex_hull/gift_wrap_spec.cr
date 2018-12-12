require "../../spec_helper"

def is_convex_hull(dcel)
  dcel.faces.each
    .flat_map { |face| dcel.values.each.map { |point| {face, point} } }
    .map { |(face, point)| {face.each_value.to_a, point} }
    .map { |(fp, point)| Geo::Simplices::Tetrahedron.new({fp[0], fp[1], fp[2], point}) }
    .all? { |t| t.signed_volume <= 0 }
end

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
      hull.edges.size.should eq(12)
      hull.faces.size.should eq(4)

      is_convex_hull(hull).should be_true
    end

    it "correctly finds the initial edge" do
      points = [
        Geo::Simplices::Point3.from_coordinates({0.0, 0.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({1.0, 1.0, 1.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({1.0, 0.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({1.0, 1.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({0.0, 1.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({0.0, 0.0, 1.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({1.0, 0.0, 1.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({0.0, 1.0, 1.0, 1.0}),
      ] # points[0..1] isn't on the hull

      gift_wrap = Geo::ConvexHull::GiftWrap.new(points)
      hull = gift_wrap.hull

      hull.values.size.should eq(8)
      hull.vertices.size.should eq(8)
      hull.edges.size.should eq((12 + 6) * 2)
      hull.faces.size.should eq(6 * 2)

      is_convex_hull(hull).should be_true
    end

    it "handles coplanar points on the boundary" do
      points = [
        Geo::Simplices::Point3.from_coordinates({0.0, 0.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({1.0, 1.0, 1.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({1.0, 0.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({1.0, 1.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({0.0, 1.0, 0.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({0.0, 0.0, 1.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({1.0, 0.0, 1.0, 1.0}),
        Geo::Simplices::Point3.from_coordinates({0.0, 1.0, 1.0, 1.0}),

        Geo::Simplices::Point3.from_coordinates({0.5, 0.5, 0.0, 1.0}),
      ]

      gift_wrap = Geo::ConvexHull::GiftWrap.new(points)
      hull = gift_wrap.hull

      hull.values.size.should eq(8)
      hull.vertices.size.should eq(8)
      hull.edges.size.should eq((12 + 6) * 2)
      hull.faces.size.should eq(6 * 2)

      is_convex_hull(hull).should be_true
    end
  end
end
