require "../../spec_helper"

describe Geo::LinearAlgebra::Matrix3x3 do
  describe "#[]" do
    matrix = Geo::LinearAlgebra::Matrix3x3.new({
      {1.0, 2.0, 3.0},
      {4.0, 5.0, 6.0},
      {7.0, 8.0, 9.0},
    })

    matrix[0, 0].should eq(1.0)
    matrix[1, 2].should eq(6.0)
  end

  describe "#det" do
    matrix = Geo::LinearAlgebra::Matrix3x3.new({
      {1.0, 3.0, 5.0},
      {7.0, 2.0, 3.0},
      {5.0, 8.0, 9.0},
    })

    matrix.det.should eq(80.0)
  end
end
