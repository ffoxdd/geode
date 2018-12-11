module Vector
  include Indexable(Float64)
  abstract def coordinates
  getter coordinates
  delegate :size, :unsafe_at, to: coordinates

  def at!(index)
    coordinates.unsafe_at(index)
  end
end
