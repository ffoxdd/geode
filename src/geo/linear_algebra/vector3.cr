struct Geo::LinearAlgebra::Vector3
  include Vector
  getter coordinates

  def initialize(@coordinates = {0.0, 0.0, 0.0})
  end

  def self.cross(v : Tuple(Vector3, Vector3))
    new({
       v[0].at!(1) * v[1].at!(2) - v[0].at!(2) * v[1].at!(1),
      -v[0].at!(0) * v[1].at!(2) + v[0].at!(2) * v[1].at!(0),
       v[0].at!(0) * v[1].at!(1) - v[0].at!(1) * v[1].at!(0)
    })
  end

  def self.dot(v : Tuple(Vector3, Vector3))
    (v[0].at!(0) * v[1].at!(0)) +
    (v[0].at!(1) * v[1].at!(1)) +
    (v[0].at!(2) * v[1].at!(2))
  end

  def dot(v)
    Vector3.dot({self, v})
  end
end
