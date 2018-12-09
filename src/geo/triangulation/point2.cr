struct Geo::Triangulation::Point2
  include Indexable(Float64)

  def initialize(@vector : Vector3)
  end

  def self.from_coordinates(coordinates : Tuple3)
    new(Vector3.new(coordinates))
  end

  getter vector
  delegate size, unsafe_at, to: vector

  def direction
    Vector2.new({vector[0], vector[1]})
  end

  def Point2.join(p1, p2)
    Line2.new(Vector3.cross(p1, p2))
  end
end
