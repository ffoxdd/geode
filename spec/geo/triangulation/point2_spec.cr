require "../../spec_helper"

describe Geo::Triangulation::Point2 do
  describe "#in_polygon?" do
    [

      {coordinates: {0.0, 0.0, 1.0}, result: true},
      {coordinates: {0.0, 1.0, 1.0}, result: true},
      {coordinates: {0.0, 3.0, 1.0}, result: true},
      {coordinates: {0.0, 0.0, 1.0}, result: true},
      {coordinates: {2.0, 1.0, 1.0}, result: true},
      {coordinates: {0.0, 3.0, 1.0}, result: true},
      {coordinates: {0.0, 2.0, 1.0}, result: true},

      {coordinates: {1.0, 1.0, 1.0}, result: true},

      {coordinates: {-1.0, 0.0, 1.0}, result: false},
      {coordinates: {4.0, 0.0, 1.0}, result: false},
      {coordinates: {0.0, -1.0, 1.0}, result: false},
      {coordinates: {0.0, 4.0, 1.0}, result: false},

      {coordinates: {3.0, 3.0, 1.0}, result: false},
      {coordinates: {-1.0, 1.0, 1.0}, result: false},
      {coordinates: {1.0, -1.0, 1.0}, result: false},

    ].each do |test|
       v1 = Geo::Triangulation::Point2.new({0.0, 0.0, 1.0})
       v2 = Geo::Triangulation::Point2.new({3.0, 0.0, 1.0})
       v3 = Geo::Triangulation::Point2.new({0.0, 3.0, 1.0})

       test_point = Geo::Triangulation::Point2.new(test[:coordinates])
       test_point.inside_polygon?(v1, v2, v3).should eq(test[:result])
    end
  end
end
