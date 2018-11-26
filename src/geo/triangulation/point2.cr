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

      right_handed?(line_1, line_2)
    end
  end

  def right_handed?(v0, v1)
    # this is a simplified version of det(v0, v1, <z=1>) >= 0
    v0[0] * v1[1] - v0[1] * v1[0] >= 0
  end

  def join(point)
    vector.cross(point.vector)
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
