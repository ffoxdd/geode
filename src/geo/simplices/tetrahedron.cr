struct Geo::Simplices::Tetrahedron
  def initialize(points : Tuple(Point3, Point3, Point3, Point3))
    @matrix = Matrix4x4.new(points.map(&.coordinates))
  end

  delegate det, at!, to: @matrix

  def signed_volume
    (-1 / 6.0) * (det / scale)
  end

  private def scale
    at!(0, 3) * at!(1, 3) * at!(2, 3) * at!(3, 3)
  end
end
