struct Geo::LinearAlgebra::Vector2
  include Vector
  getter coordinates

  def initialize(@coordinates = {0.0, 0.0})
  end
end
