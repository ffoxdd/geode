require "./linear_algebra"

struct Geo::LinearAlgebra::Matrix4x4
  include Matrix

  def initialize(@elements : Tuple4x4)
  end

  def unsafe_fetch(index : Index)
    @elements[index[0]][index[1]]
  end

  def shape
    {4, 4}
  end

  def det
    at!(0, 0) * (
      at!(1, 1) * ((at!(2, 2) * at!(3, 3)) - (at!(3, 2) * at!(2, 3))) -
      at!(1, 2) * ((at!(2, 1) * at!(3, 3)) - (at!(3, 1) * at!(2, 3))) +
      at!(1, 3) * ((at!(2, 1) * at!(3, 2)) - (at!(3, 1) * at!(2, 2)))
    ) -
    at!(0, 1) * (
      at!(1, 0) * ((at!(2, 2) * at!(3, 3)) - (at!(3, 2) * at!(2, 3))) -
      at!(1, 2) * ((at!(2, 0) * at!(3, 3)) - (at!(3, 0) * at!(2, 3))) +
      at!(1, 3) * ((at!(2, 0) * at!(3, 2)) - (at!(3, 0) * at!(2, 2)))
    ) +
    at!(0, 2) * (
      at!(1, 0) * ((at!(2, 1) * at!(3, 3)) - (at!(3, 1) * at!(2, 3))) -
      at!(1, 1) * ((at!(2, 0) * at!(3, 3)) - (at!(3, 0) * at!(2, 3))) +
      at!(1, 3) * ((at!(2, 0) * at!(3, 1)) - (at!(3, 0) * at!(2, 1)))
    ) -
    at!(0, 3) * (
      at!(1, 0) * ((at!(2, 1) * at!(3, 2)) - (at!(3, 1) * at!(2, 2))) -
      at!(1, 1) * ((at!(2, 0) * at!(3, 2)) - (at!(3, 0) * at!(2, 2))) +
      at!(1, 2) * ((at!(2, 0) * at!(3, 1)) - (at!(3, 0) * at!(2, 1)))
    )
  end
end
