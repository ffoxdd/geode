struct Geo::Triangulation::Point2
  include Indexable(Float64)

  def initialize(@vector : Vector3)
  end

  def self.from_coordinates(coordinates : Tuple3)
    new(Vector3.new(coordinates))
  end

  getter vector
  delegate size, unsafe_at, coordinates, to: vector
end
