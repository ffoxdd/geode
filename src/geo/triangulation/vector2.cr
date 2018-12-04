struct Geo::Triangulation::Vector2
  def initialize(@coordinates = {0.0, 0.0})
  end

  getter coordinates
  delegate :[], to: coordinates

  def Vector2.det(v1, v2)
    v1[0] * v2[1] - v1[1] * v2[0]
  end
end
