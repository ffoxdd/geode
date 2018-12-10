require "./linear_algebra"

struct Geo::LinearAlgebra::Matrix3x3
  include Matrix

  alias Tuple3 = Tuple(Float64, Float64, Float64)
  alias Tuple3x3 = Tuple(Tuple3, Tuple3, Tuple3)

  def initialize(@elements : Tuple3x3)
  end

  def unsafe_at(index : Index)
    @elements[index[0]][index[1]]
  end

  def shape
    {3, 3}
  end

  def det
    @elements[0][0] * ((@elements[1][1] * @elements[2][2]) - (@elements[2][1] * @elements[1][2])) -
    @elements[0][1] * ((@elements[1][0] * @elements[2][2]) - (@elements[2][0] * @elements[1][2])) +
    @elements[0][2] * ((@elements[1][0] * @elements[2][1]) - (@elements[2][0] * @elements[1][1]))
  end
end
