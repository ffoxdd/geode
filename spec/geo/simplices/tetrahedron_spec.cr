require "../../spec_helper"

describe Geo::Simplices::Tetrahedron do
  describe "#signed_volume" do
    [
      {
        tetrahedron: {
          {0.0, 0.0, 0.0, 1.0},
          {1.0, 0.0, 0.0, 1.0},
          {0.0, 1.0, 0.0, 1.0},
          {0.0, 0.0, 1.0, 1.0},
        },

        result: (1 / 6.0)
      },

      {
        tetrahedron: {
          {0.0, 0.0, 0.0, 1.0},
          {-1.0, 0.0, 0.0, 1.0},
          {0.0, 1.0, 0.0, 1.0},
          {0.0, 0.0, 1.0, 1.0},
        },

        result: -(1 / 6.0)
      },

      {
        tetrahedron: {
          {0.0, 0.0, 0.0, 1.0},
          {1.0, 0.0, 0.0, 1.0},
          {0.0, -1.0, 0.0, 1.0},
          {0.0, 0.0, 1.0, 1.0},
        },

        result: -(1 / 6.0)
      },

      {
        tetrahedron: {
          {0.0, 0.0, 0.0, 1.0},
          {1.0, 0.0, 0.0, 1.0},
          {0.0, 1.0, 0.0, 1.0},
          {0.0, 0.0, -1.0, 1.0},
        },

        result: -(1 / 6.0)
      },

      {
        tetrahedron: {
          {0.0, 0.0, 0.0, 1.0},
          {-1.0, 0.0, 0.0, -1.0},
          {0.0, 1.0, 0.0, 1.0},
          {0.0, 0.0, 1.0, 1.0},
        },

        result: (1 / 6.0)
      },

      {
        tetrahedron: {
          {0.0, 0.0, 0.0, 1.0},
          {1.0, 0.0, 0.0, -1.0},
          {0.0, 1.0, 0.0, 1.0},
          {0.0, 0.0, 1.0, 1.0},
        },

        result: -(1 / 6.0)
      },

      {
        tetrahedron: {
          {0.0, 0.0, 0.0, 3.0},
          {2.0, 0.0, 0.0, 2.0},
          {0.0, -4.0, 0.0, -4.0},
          {0.0, 0.0, -6.0, -6.0},
        },

        result: (1 / 6.0)
      },
    ].each do |test|
      it "returns #{test[:result]} for #{test[:tetrahedron]}" do
        points = test[:tetrahedron].map do |coordinates|
          Geo::Simplices::Point3.from_coordinates(coordinates)
        end

        tetrahedron = Geo::Simplices::Tetrahedron.new(points)
        tetrahedron.signed_volume.should eq(test[:result])
      end
    end
  end
end
