require "../../spec_helper"

describe Geo::Simplices::Triangle3 do
  describe "#area" do
    [
      {
        coordinates: {
          {0.0, 0.0, 0.0, 1.0},
          {1.0, 0.0, 0.0, 1.0},
          {0.0, 1.0, 0.0, 1.0}
        },

        result: 0.5,
      },

      {
        coordinates: {
          {1.0, 0.0, 0.0, 1.0},
          {0.0, 0.0, 0.0, 1.0},
          {0.0, 1.0, 0.0, 1.0}
        },

        result: 0.5,
      },

      {
        coordinates: {
          {0.0, 0.0, 0.0, 1.0},
          {-1.0, 0.0, 0.0, -1.0},
          {0.0, 1.0, 0.0, 1.0}
        },

        result: 0.5,
      },

      {
        coordinates: {
          {0.0, 0.0, 0.0, 3.0},
          {-5.0, 0.0, 0.0, -5.0},
          {0.0, -2.0, 0.0, -2.0}
        },

        result: 0.5,
      },
    ].each do |test|
      it "returns #{test[:result]} for #{test[:coordinates]}" do
        triangle_points = test[:coordinates].map do |coordinates|
          Geo::Simplices::Point3.from_coordinates(coordinates)
        end

        triangle = Geo::Simplices::Triangle3.new(triangle_points)

        triangle.area.should eq(test[:result])
      end
    end
  end
end
