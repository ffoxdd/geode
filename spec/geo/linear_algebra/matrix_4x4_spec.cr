require "../../spec_helper"

describe Geo::LinearAlgebra::Matrix4x4 do
  describe "#[]" do
    matrix = Geo::LinearAlgebra::Matrix4x4.new({
      {11.0, 12.0, 13.0, 14.0},
      {21.0, 22.0, 23.0, 24.0},
      {31.0, 32.0, 33.0, 34.0},
      {41.0, 42.0, 43.0, 44.0},
    })

    matrix[0, 0].should eq(11.0)
    matrix[2, 3].should eq(34.0)
  end

  describe "#det" do
    matrix = Geo::LinearAlgebra::Matrix4x4.new({
      {1.0, 3.0, 5.0, 7.0},
      {7.0, 2.0, 3.0, 3.0},
      {5.0, 8.0, 9.0, 2.0},
      {3.0, 2.0, 1.0, 9.0},
    })

    matrix.det.should eq(1070.0)
  end
end
