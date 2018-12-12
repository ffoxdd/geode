struct Geo::LinearAlgebra::Vector2
  include Vector
  getter coordinates

  def initialize(@coordinates = {0.0, 0.0})
  end

  def self.dot(v : Tuple(Vector2, Vector2))
    (v[0].at!(0) * v[1].at!(0)) +
    (v[0].at!(1) * v[1].at!(1))
  end

  def dot(v)
    Vector2.dot({self, v})
  end
end
