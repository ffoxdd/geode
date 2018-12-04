struct Geo::Triangulation::Point2
  def initialize(coordinates = {0.0, 0.0, 1.0})
    @vector = Vector3.new(coordinates)
  end

  getter vector
  delegate :[], to: vector

  def Point2.right_handed?(v0, v1)
    # this is a simplified version of det(v0, v1, <z=1>) >= 0
    v0[0] * v1[1] - v0[1] * v1[0] >= 0
  end

  def Point2.join(p1, p2)
    Vector3.cross(p1, p2)
  end

  private struct Vector3
    def initialize(@coordinates = {0.0, 0.0, 1.0})
    end

    getter coordinates
    delegate :[], to: coordinates

    def Vector3.cross(v1, v2)
      Vector3.new({
         v1[1] * v2[2] - v1[2] * v2[1],
        -v1[0] * v2[2] + v1[2] * v2[0],
         v1[0] * v2[1] - v1[1] * v2[0]
      })
    end
  end
end
