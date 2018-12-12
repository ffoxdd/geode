struct Geo::Simplices::Triangle2
  def initialize(@points : Tuple(Point2, Point2, Point2))
  end

  def contains?(point)
    inner_triangles(point).all? { |triangle| triangle.area_sign >= 0 }
  end

  def signed_area
    TriangleMatrix2.new(coordinates)
  end

  private def coordinates
    @points.map(&.coordinates)
  end

  private def inner_triangles(point)
    each_edge_point_pair
      .map { |points| {points[0], points[1], point} }
      .map { |points| points.map(&.coordinates) }
      .map { |points| TriangleMatrix2.new(points) }
  end

  private def each_edge_point_pair
    @points.each.cycle.cons(2, true).first(3)
  end

  private struct TriangleMatrix2
    def initialize(coordinates : Tuple3x3)
      @matrix = Matrix3x3.new(coordinates)
    end

    delegate det, at!, to: @matrix

    def area_sign
      det / scale_sign
    end

    def area
      det / scale
    end

    private def scale_sign
      sign(at!(0, 2)) * sign(at!(1, 2)) * sign(at!(2, 2))
    end

    private def scale
      at!(0, 2) * at!(1, 2) * at!(2, 2)
    end

    private def sign(n)
      n == 0 ? 1 : n
    end
  end
end
