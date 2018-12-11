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
      .map { |vertices| {vertices[0], vertices[1]} }
      .first(@vertices.size)
      .map { |vertices| Edge.new(vertices) }
  end

  private class Edge
    def initialize(@vertices : Tuple(Point2, Point2))
    end

    def can_see?(point)
      triangle(point).area_sign >= 0
    end

    private def triangle(point)
      Triangle.new(*@vertices, point)
    end
  end

  private class Triangle
    def initialize(*vertices)
      @matrix = Matrix3x3.new(vertices.map(&.coordinates))
    end

    def area_sign
      @matrix.det / det_sign
    end

    private def det_sign
      (0...3).map { |i| sign(@matrix[i, 2]) }.reduce { |a, b| a * b }
    end

    private def sign(n)
      return 1 if n == 0
      n.sign
    end
  end
end
