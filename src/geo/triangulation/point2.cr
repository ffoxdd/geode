struct Geo::Triangulation::Point2
  def initialize(coordinates = {0.0, 0.0, 1.0})
    @vector = Vector3.new(coordinates)
  end

  getter vector
  delegate :[], to: vector

  def inside_polygon?(*vertices)
    edges = [] of Array(Point2)

    vertices.cycle.first(vertices.size + 1).each_cons(2) do |edge_vertices|
      edges << edge_vertices
    end

    edges.all? do |(v0, v1)|
      line_1 = v0.join(v1)
      line_2 = v0.join(self)

      line_1.right_handed?(line_2)
    end
  end

  def right_handed?(line)
    # this is a simplified version of det(self, line, z=1) > 0
    self[0] * line[1] - self[1] * line[0] >= 0
  end

  # TODO: consider returning a vector instead of a point here (it's technically a line)
  def join(point)
    Point2.new(vector.cross(point.vector).coordinates)
  end

  private struct Vector3
    def initialize(@coordinates = {0.0, 0.0, 1.0})
    end

    getter coordinates
    delegate :[], to: coordinates

    def cross(vector)
      Vector3.new({
         self[1] * vector[2] - self[2] * vector[1],
        -self[0] * vector[2] + self[2] * vector[0],
         self[0] * vector[1] - self[1] * vector[0]
      })
    end
  end
end
