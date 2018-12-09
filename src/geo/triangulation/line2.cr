struct Geo::Triangulation::Line2
  include Indexable(Float64)

  def initialize(@vector : Vector3)
  end

  def self.from_coordinates(coordinates : Tuple3)
    new(Vector3.new(coordinates))
  end

  getter vector
  delegate size, unsafe_at, to: vector

  def dual
    Point2.new(vector)
  end

  def self.right_handed?(l0, l1)
    v0 = l0.dual.direction
    v1 = l1.dual.direction

    Vector2.det(v0, v1) >= 0
  end
end
