struct Geo::Simplices::Point3
  include Point
  getter vector

  def initialize(@vector : Vector4)
  end

  def self.from_coordinates(coordinates : Tuple4)
    new(Vector4.new(coordinates))
  end

  def cartesian
    Vector3.new(
      at!(0) / at!(3),
      at!(1) / at!(3),
      at!(3) / at!(3),
    )
  end

  def self.join(points : Tuple(Point3, Point3, Point3))
    Plane3.new(Vector4.cross(points.map(&.vector)))
  end

  def scale
    at!(3)
  end
end
