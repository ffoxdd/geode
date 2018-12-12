require "./linear_algebra"

module Geo::LinearAlgebra::Matrix
  abstract def unsafe_fetch(index : Index)
  abstract def shape : Index
  abstract def det

  include Indexable(Float64)

  def size
    shape.reduce { |i, j| i * j }
  end

  def unsafe_fetch(index : Int32)
    unsafe_fetch(index_as_tuple(index))
  end

  def unsafe_fetch(*index)
    unsafe_fetch(index)
  end

  def at!(*index)
    unsafe_fetch(index)
  end

  def fetch(index : Index)
    assert_in_bounds(index)
    unsafe_fetch(index)
  end

  def fetch(*index)
    fetch(index)
  end

  def [](index : Index)
    fetch(index)
  end

  def [](*index)
    fetch(index)
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
