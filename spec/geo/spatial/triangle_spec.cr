require "../../spec_helper"

describe Geo::Spatial::Triangle do
  describe "#contains?" do
    [
      { # bounded triangle
        triangle: {
          {0.0, 0.0, 1.0},
          {3.0, 0.0, 1.0},
          {0.0, 3.0, 1.0},
        },

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

      { # infinite
        triangle: {
          {0.0, 0.0, 1.0},
          {1.0, 1.0, 0.0},
          {0.0, 1.0, 0.0},
        },

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

      { # mixed scale
        triangle: {
          {0.0, 0.0, -2.0},
          {9.0, 0.0, 3.0},
          {0.0, -3.0, -1.0},
        },

        tests: [
          {point: {1.0, 1.0, 1.0}, result: true},
          {point: {-1.0, -1.0, -1.0}, result: true},
        ],
      },
    ]

    [

      { # bounded triangle
        triangle: {
          {0.0, 0.0, 1.0},
          {3.0, 0.0, 1.0},
          {0.0, 3.0, 1.0},
        },

        tests: [
          # {point: {-1.0, -1.0, -1.0}, result: true},
          {point: {-1.0, 0.0, 1.0}, result: false},
        ],
      }

    ].each do |setup|
      setup[:tests].each do |test|
        it "returns #{test[:result]} for #{test[:point]} in #{setup[:triangle]}" do
          triangle_points = setup[:triangle].map do |coordinates|
            Geo::Spatial::Point2.from_coordinates(coordinates)
          end

          triangle = Geo::Spatial::Triangle.new(triangle_points)
          test_point = Geo::Spatial::Point2.from_coordinates(test[:point])

          triangle.contains?(test_point).should eq(test[:result])
        end
      end
    end
  end
end
