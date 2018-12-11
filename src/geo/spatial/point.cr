module Geo::Spatial::Point
  abstract def vector
  include Indexable(Float64)
  delegate size, unsafe_at, coordinates, at!, to: vector
end
