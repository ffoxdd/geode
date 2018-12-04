struct Geo::Triangulation::Vector3
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
