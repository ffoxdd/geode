struct Geo::LinearAlgebra::Vector3
  def initialize(@coordinates = {0.0, 0.0, 0.0})
  end

  getter coordinates
  delegate :[], to: coordinates

  def self.cross(v1, v2)
    new({
       v1[1] * v2[2] - v1[2] * v2[1],
      -v1[0] * v2[2] + v1[2] * v2[0],
       v1[0] * v2[1] - v1[1] * v2[0]
    })
  end
end
