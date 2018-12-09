struct Geo::LinearAlgebra::Vector2
  include Indexable(Float64)

  def initialize(@coordinates = {0.0, 0.0})
  end

  getter coordinates
  delegate :size, :unsafe_at, to: coordinates

  def self.det(v1, v2)
    v1[0] * v2[1] - v1[1] * v2[0]
  end
end
