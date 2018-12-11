require "./linear_algebra"

module Geo::LinearAlgebra::Matrix
  abstract def unsafe_at(index : Index)
  abstract def shape : Index
  abstract def det

  include Indexable(Float64)

  def size
    shape.reduce { |i, j| i * j }
  end

  def unsafe_at(index : Int32)
    at(index_as_tuple(index))
  end

  def unsafe_at(*index)
    unsafe_at(index)
  end

  def at(index : Index)
    assert_in_bounds(index)
    unsafe_at(index)
  end

  def at(*index)
    at(index)
  end

  def [](index : Index)
    at(index)
  end

  def [](*index)
    at(index)
  end

  def e(i, j)
    @elements[i][j]
  end

  def square?
    shape[0] == shape[1]
  end

  def assert_in_bounds(index)
    raise IndexError.new unless index_in_bounds?(index)
  end

  private def index_in_bounds?(index)
    index[0] < shape[0] && index[1] < shape[1]
  end

  private def index_as_tuple(index : Int32)
    index.divmod(shape[0])
  end
end
