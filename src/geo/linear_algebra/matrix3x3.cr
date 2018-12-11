require "./linear_algebra"

struct Geo::LinearAlgebra::Matrix3x3
  include Matrix

  def initialize(@elements : Tuple3x3)
  end

  def unsafe_at(index : Index)
    @elements[index[0]][index[1]]
  end

  def shape
    {3, 3}
  end

  def det
    e(0, 0) * ((e(1, 1) * e(2, 2)) - (e(2, 1) * e(1, 2))) -
    e(0, 1) * ((e(1, 0) * e(2, 2)) - (e(2, 0) * e(1, 2))) +
    e(0, 2) * ((e(1, 0) * e(2, 1)) - (e(2, 0) * e(1, 1)))
  end
end
