module Vector
  include Indexable(Float64)
  abstract def coordinates
  getter coordinates
  delegate size, unsafe_fetch, to: coordinates

  def at!(index)
    coordinates.unsafe_fetch(index)
  end
end
