struct Geo::LinearAlgebra::Vector3
  include Vector
  getter coordinates

  def initialize(@coordinates = {0.0, 0.0, 0.0})
  end

  def self.cross(v1, v2)
    new({
       v1.at!(1) * v2.at!(2) - v1.at!(2) * v2.at!(1),
      -v1.at!(0) * v2.at!(2) + v1.at!(2) * v2.at!(0),
       v1.at!(0) * v2.at!(1) - v1.at!(1) * v2.at!(0)
    })
  end
end
