struct Geo::Triangulation::Line2
  @vector : Vector3

  def initialize(@vector)
  end

  def Line2.from_coordinates(coordinates : Tuple(Float64, Float64, Float64))
    Line2.new(Vector3.new(coordinates))
  end

  getter vector
  delegate :[], to: vector

  def dual
    Point2.new(vector)
  end

  def Line2.right_handed?(l0, l1)
    v0 = l0.dual.direction
    v1 = l1.dual.direction

    Vector2.det(v0, v1) >= 0
  end
end
