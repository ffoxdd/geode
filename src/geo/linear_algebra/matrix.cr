require "./linear_algebra"

module Geo::LinearAlgebra::Matrix
  abstract def unsafe_at(index : Index)
  abstract def shape : Index

  def size
    shape.reduce { |i, j| i * j }
  end

  def unsafe_at(index : Int32)
    at(index_as_tuple(index))
  end

  def unsafe_at(*index : Index)
    unsafe_at(index)
  end

  include Indexable(Float64)

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

  def square?
    shape[0] == shape[1]
  end

  def det
    raise "matrix must be square" if !square?
    return first if size == 1

    each_index_for_row(0)
      .map { |index| at(index) * cofactor(index) }
      .reduce { |a, b| a + b }
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

  private def cofactor(index)
    cofactor_sign(index) * minor(index)
  end

  private def cofactor_sign(index)
    -1 ** index.reduce { |a, b| a + b }
  end

  private def minor(index)
    SubMatrix.new(self, skip: index).det
  end

  private def each_index_for_row(i)
    (0...shape[1]).each.map { |j| {i, j} }
  end
end
