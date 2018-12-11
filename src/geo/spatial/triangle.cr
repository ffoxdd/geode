struct Geo::Spatial::Triangle
  def initialize(points : Tuple(Point2, Point2, Point2))
    @points = points
  end

  def contains?(point)
    inner_triangles(point).all? { |triangle| triangle.area_sign >= 0 }
  end

  private def inner_triangles(point)
    each_edge_point_pair
      .map { |points| {points[0], points[1], point} }
      .map { |points| points.map(&.coordinates) }
      .map { |points| TriangleMatrix.new(points) }
  end

  private def each_edge_point_pair
    @points.each.cycle.cons(2, true).first(3)
  end

  private struct TriangleMatrix
    def initialize(coordinates : Tuple3x3)
      @matrix = Matrix3x3.new(coordinates)
    end

    def area_sign
      @matrix.det / scale_sign
    end

    private def scale_sign
      sign(at(0, 2)) * sign(at(1, 2)) * sign(at(2, 2))
    end

    private def sign(n)
      n == 0 ? 1 : n
    end

    private def at(i, j)
      @matrix.unsafe_at({i, j})
    end
  end
end
