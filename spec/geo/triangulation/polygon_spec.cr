require "../../spec_helper"

describe Geo::Triangulation::Polygon do
  describe "#contains?" do
    [

      # inside
      {coordinates: {1.0, 1.0, 1.0}, result: true},

      # on the perimeter
      {coordinates: {0.0, 0.0, 1.0}, result: true},
      {coordinates: {0.0, 1.0, 1.0}, result: true},
      {coordinates: {0.0, 3.0, 1.0}, result: true},
      {coordinates: {0.0, 0.0, 1.0}, result: true},
      {coordinates: {2.0, 1.0, 1.0}, result: true},
      {coordinates: {0.0, 3.0, 1.0}, result: true},
      {coordinates: {0.0, 2.0, 1.0}, result: true},

      # outside
      {coordinates: {-1.0, 0.0, 1.0}, result: false},
      {coordinates: {4.0, 0.0, 1.0}, result: false},
      {coordinates: {0.0, -1.0, 1.0}, result: false},
      {coordinates: {0.0, 4.0, 1.0}, result: false},
      {coordinates: {3.0, 3.0, 1.0}, result: false},
      {coordinates: {-1.0, 1.0, 1.0}, result: false},
      {coordinates: {1.0, -1.0, 1.0}, result: false},

    ].each do |test|
      p1 = Geo::Triangulation::Point2.from_coordinates({0.0, 0.0, 1.0})
      p2 = Geo::Triangulation::Point2.from_coordinates({3.0, 0.0, 1.0})
      p3 = Geo::Triangulation::Point2.from_coordinates({0.0, 3.0, 1.0})

      polygon = Geo::Triangulation::Polygon.new([p1, p2, p3])

      test_point = Geo::Triangulation::Point2.from_coordinates(test[:coordinates])
      polygon.contains?(test_point).should eq(test[:result])
    end
  end
end
