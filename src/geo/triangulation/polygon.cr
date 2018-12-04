class Geo::Triangulation::Polygon
  @vertices : Array(Point2)

  def initialize(*vertices)
    @vertices = vertices.to_a
  end

  def contains?(point)
    edges = [] of Array(Point2)

    @vertices.cycle.first(@vertices.size + 1).each_cons(2) do |edge_vertices|
      edges << edge_vertices
    end

    edges.all? do |(v0, v1)|
      line_1 = Point2.join(v0, v1)
      line_2 = Point2.join(v0, point)

      Point2.right_handed?(line_1, line_2)
    end
  end

  def right_handed?(v0, v1)
    # this is a simplified version of det(v0, v1, <z=1>) >= 0
    v0[0] * v1[1] - v0[1] * v1[0] >= 0
  end

  def join(point)
    vector.cross(point.vector)
  end
end
