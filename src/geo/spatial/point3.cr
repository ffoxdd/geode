struct Geo::Spatial::Point3
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
end
