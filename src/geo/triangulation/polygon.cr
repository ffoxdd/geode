class Geo::Triangulation::Polygon
  def initialize(@vertices : Array(Point2))
  end

  def contains?(point)
    each_edge.all? { |edge| edge.can_see?(point) }
  end

  private def each_edge
    @vertices.each
      .cycle
      .cons(2, true)
      .first(@vertices.size)
      .map { |vertices| Edge.new(vertices) }
  end

  private class Edge
    def initialize(@vertices : Array(Point2))
    end

    def can_see?(point)
      triangle_matrix(point).det >= 0
    end

    private def triangle_matrix(point)
      Matrix3x3.new({
        @vertices[0].vector.coordinates,
        @vertices[1].vector.coordinates,
        point.vector.coordinates
      })
    end
  end
end
