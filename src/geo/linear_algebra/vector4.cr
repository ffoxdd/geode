struct Geo::LinearAlgebra::Vector4
  include Vector
  getter coordinates

  def initialize(@coordinates = {0.0, 0.0, 0.0, 0.0})
  end
end
