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
    at!(0, 0) * ((at!(1, 1) * at!(2, 2)) - (at!(2, 1) * at!(1, 2))) -
    at!(0, 1) * ((at!(1, 0) * at!(2, 2)) - (at!(2, 0) * at!(1, 2))) +
    at!(0, 2) * ((at!(1, 0) * at!(2, 1)) - (at!(2, 0) * at!(1, 1)))
  end
end
