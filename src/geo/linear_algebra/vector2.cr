struct Geo::LinearAlgebra::Vector2
  include Indexable(Float64)

  def initialize(@coordinates = {0.0, 0.0})
  end

  getter coordinates
  delegate :size, :unsafe_at, to: coordinates
end
