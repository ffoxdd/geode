class Geo::Triangulation::Polygon
  def initialize(vertices : Array(Point2))
    @vertices = vertices
  end

  def contains?(point)
    each_edge.all? { |edge| edge.can_see?(point) }
  end

  private def each_edge
    EdgeIterator.new(@vertices)
  end

  private class Edge
    def initialize(@vertex_0 : Point2, @vertex_1 : Point2)
    end

    def can_see?(point)
      Line2.right_handed?(edge_line, incident_line(point))
    end

    private def edge_line
      Point2.join(@vertex_0, @vertex_1)
    end

    private def incident_line(point)
      Point2.join(@vertex_0, point)
    end
  end

  private class EdgeIterator
    include Iterator(Edge)

    def initialize(@vertices : Array(Point2))
      @index = 0
    end

    def next
      return stop if @index > (@vertices.size - 1)
      current_edge.tap { @index += 1 }
    end

    def rewind
      @index = 0
    end

    private def current_edge
      Edge.new(@vertices[@index], @vertices[next_index])
    end

    private def next_index
      (@index + 1) % @vertices.size
    end
  end
end
