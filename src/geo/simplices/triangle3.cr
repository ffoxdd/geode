struct Geo::Simplices::Triangle3
  def initialize(@points : Tuple(Point3, Point3, Point3))
  end

  def area
    n = plane_normal
    (Math.sqrt(n.dot(n)) / (2 * scale_product)).abs
  end

  private def scale_product
    @points[0].scale * @points[1].scale * @points[2].scale
  end

  private def plane_normal
    Point3.join(@points).normal
  end
end
