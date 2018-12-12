struct Geo::LinearAlgebra::Vector4
  include Vector
  getter coordinates

  def initialize(@coordinates = {0.0, 0.0, 0.0, 0.0})
  end

  def self.cross(v : Tuple(Vector4, Vector4, Vector4))
    new({
      (
        v[0].at!(1) * ((v[1].at!(2) * v[2].at!(3)) - (v[2].at!(2) * v[1].at!(3))) -
        v[0].at!(2) * ((v[1].at!(1) * v[2].at!(3)) - (v[2].at!(1) * v[1].at!(3))) +
        v[0].at!(3) * ((v[1].at!(1) * v[2].at!(2)) - (v[2].at!(1) * v[1].at!(2)))
      ),
      -(
        v[0].at!(0) * ((v[1].at!(2) * v[2].at!(3)) - (v[2].at!(2) * v[1].at!(3))) -
        v[0].at!(2) * ((v[1].at!(0) * v[2].at!(3)) - (v[2].at!(0) * v[1].at!(3))) +
        v[0].at!(3) * ((v[1].at!(0) * v[2].at!(2)) - (v[2].at!(0) * v[1].at!(2)))
      ),
      (
        v[0].at!(0) * ((v[1].at!(1) * v[2].at!(3)) - (v[2].at!(1) * v[1].at!(3))) -
        v[0].at!(1) * ((v[1].at!(0) * v[2].at!(3)) - (v[2].at!(0) * v[1].at!(3))) +
        v[0].at!(3) * ((v[1].at!(0) * v[2].at!(1)) - (v[2].at!(0) * v[1].at!(1)))
      ),
      -(
        v[0].at!(0) * ((v[1].at!(1) * v[2].at!(2)) - (v[2].at!(1) * v[1].at!(2))) -
        v[0].at!(1) * ((v[1].at!(0) * v[2].at!(2)) - (v[2].at!(0) * v[1].at!(2))) +
        v[0].at!(2) * ((v[1].at!(0) * v[2].at!(1)) - (v[2].at!(0) * v[1].at!(1)))
      )
    })
  end

  def self.dot(v : Tuple(Vector4, Vector4))
    (v[0].at!(0) * v[1].at!(0)) +
    (v[0].at!(1) * v[1].at!(1)) +
    (v[0].at!(2) * v[1].at!(2)) +
    (v[0].at!(3) * v[1].at!(3))
  end

  def dot(v)
    Vector4.dot({self, v})
  end
end
