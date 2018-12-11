require "../../spec_helper"

describe Geo::Spatial::Polygon do
  describe "#contains?" do
    [
      {
        # bounded triangle
        polygon: [
          {0.0, 0.0, 1.0},
          {3.0, 0.0, 1.0},
          {0.0, 3.0, 1.0},
        ],

        tests: [
          # inside
          {point: {1.0, 1.0, 1.0}, result: true},
          {point: {-1.0, -1.0, -1.0}, result: true},

          # on the perimeter
          {point: {0.0, 0.0, 1.0}, result: true},
          {point: {0.0, 1.0, 1.0}, result: true},
          {point: {0.0, 3.0, 1.0}, result: true},
          {point: {0.0, 0.0, 1.0}, result: true},
          {point: {2.0, 1.0, 1.0}, result: true},
          {point: {0.0, 3.0, 1.0}, result: true},
          {point: {0.0, 2.0, 1.0}, result: true},

          # outside
          {point: {-1.0, 0.0, 1.0}, result: false},
          {point: {4.0, 0.0, 1.0}, result: false},
          {point: {0.0, -1.0, 1.0}, result: false},
          {point: {0.0, 4.0, 1.0}, result: false},
          {point: {3.0, 3.0, 1.0}, result: false},
          {point: {-1.0, 1.0, 1.0}, result: false},
          {point: {1.0, -1.0, 1.0}, result: false},
        ],
      },

      {
        # infinite triangle
        polygon: [
          {0.0, 0.0, 1.0},
          {1.0, 1.0, 0.0},
          {0.0, 1.0, 0.0},
        ],

        tests: [
          {point: {0.0, 0.0, 1.0}, result: true},
          {point: {3.0, 3.0, 1.0}, result: true},
          {point: {2.0, 2.0, 0.0}, result: true},
          {point: {0.0, 1.0, 0.0}, result: true},
          {point: {0.0, 1.0, 1.0}, result: true},
          {point: {1.0, 2.0, 1.0}, result: true},
          {point: {1.0, 1.1, 0.0}, result: true},

          {point: {1.0, 0.0, 1.0}, result: false},
          {point: {0.0, -1.0, 1.0}, result: false},
          {point: {-1.0, 0.0, 1.0}, result: false},
          {point: {1.1, 1.0, 0.0}, result: false},
          {point: {1.0, 0.0, 1.0}, result: false},
        ],
      },

      {
        # mixed scale triangle
        polygon: [
          {0.0, 0.0, -2.0},
          {9.0, 0.0, 3.0},
          {0.0, -3.0, -1.0},
        ],

        tests: [
          {point: {1.0, 1.0, 1.0}, result: true},
          {point: {-1.0, -1.0, -1.0}, result: true},
        ],
      },

    ].each do |setup|
      setup[:tests].each do |test|
        it "returns #{test[:result]} for #{test[:point]} in #{setup[:polygon]}" do
          polygon_points = setup[:polygon].map do |coordinates|
            Geo::Spatial::Point2.from_coordinates(coordinates)
          end

          polygon = Geo::Spatial::Polygon.new(polygon_points)

          test_point = Geo::Spatial::Point2.from_coordinates(test[:point])
          polygon.contains?(test_point).should eq(test[:result])
        end
      end
    end
  end
end