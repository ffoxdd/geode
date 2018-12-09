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
      Line2.right_handed?(edge_line, incident_line(point))
    end

    private def edge_line
      Point2.join(@vertices[0], @vertices[1])
    end

    private def incident_line(point)
      Point2.join(@vertices[0], point)
    end
  end
end
