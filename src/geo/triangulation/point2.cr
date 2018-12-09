struct Geo::Triangulation::Point2
  def initialize(@vector : Vector3)
  end

  def self.from_coordinates(coordinates : Tuple3)
    new(Vector3.new(coordinates))
  end

  getter vector
  delegate :[], to: vector

  def direction
    Vector2.new({vector[0], vector[1]})
  end

  def Point2.join(p1, p2)
    Line2.new(Vector3.cross(p1, p2))
  end
end
