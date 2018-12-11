require "./linear_algebra"

struct Geo::LinearAlgebra::Matrix4x4
  include Matrix

  alias Tuple4 = Tuple(Float64, Float64, Float64, Float64)
  alias Tuple4x4 = Tuple(Tuple4, Tuple4, Tuple4, Tuple4)

  def initialize(@elements : Tuple4x4)
  end

  def unsafe_at(index : Index)
    @elements[index[0]][index[1]]
  end

  def shape
    {4, 4}
  end

  def det
    e(0, 0) * (
      e(1, 1) * ((e(2, 2) * e(3, 3)) - (e(3, 2) * e(2, 3))) -
      e(1, 2) * ((e(2, 1) * e(3, 3)) - (e(3, 1) * e(2, 3))) +
      e(1, 3) * ((e(2, 1) * e(3, 2)) - (e(3, 1) * e(2, 2)))
    ) -
    e(0, 1) * (
      e(1, 0) * ((e(2, 2) * e(3, 3)) - (e(3, 2) * e(2, 3))) -
      e(1, 2) * ((e(2, 0) * e(3, 3)) - (e(3, 0) * e(2, 3))) +
      e(1, 3) * ((e(2, 0) * e(3, 2)) - (e(3, 0) * e(2, 2)))
    ) +
    e(0, 2) * (
      e(1, 0) * ((e(2, 1) * e(3, 3)) - (e(3, 1) * e(2, 3))) -
      e(1, 1) * ((e(2, 0) * e(3, 3)) - (e(3, 0) * e(2, 3))) +
      e(1, 3) * ((e(2, 0) * e(3, 1)) - (e(3, 0) * e(2, 1)))
    ) -
    e(0, 3) * (
      e(1, 0) * ((e(2, 1) * e(3, 2)) - (e(3, 1) * e(2, 2))) -
      e(1, 1) * ((e(2, 0) * e(3, 2)) - (e(3, 0) * e(2, 2))) +
      e(1, 2) * ((e(2, 0) * e(3, 1)) - (e(3, 0) * e(2, 1)))
    )
  end

  private def e(i, j)
    @elements[i][j]
  end
end
