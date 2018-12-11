struct Geo::Simplices::Point2
  include Point
  getter vector

  def initialize(@vector : Vector3)
  end

  def self.from_coordinates(coordinates : Tuple3)
    new(Vector3.new(coordinates))
  end

  def cartesian
    Vector2.new(
      at!(0) / at!(2),
      at!(1) / at!(2),
    )
  end
end
