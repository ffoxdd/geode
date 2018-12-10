class Geo::LinearAlgebra::SubMatrix
  include Matrix
  @skip : Index?

  def initialize(@base_matrix : Matrix, @skip = nil)
    @base_matrix.assert_in_bounds(@skip.not_nil!) if @skip
  end

  def unsafe_at(index : Index)
    @base_matrix.at(base_index(index))
  end

  def shape
    @base_matrix.shape.map { |i| i - 1 }
  end

  private def base_index(index : Index)
    return index if @skip.nil?

    {
      base_index_component(index[0], 0),
      base_index_component(index[1], 1),
    }
  end

  private def base_index_component(i, dimension)
    i < @skip.not_nil![dimension] ? i : i + 1
  end
end
