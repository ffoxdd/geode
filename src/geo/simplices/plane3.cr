struct Geo::Simplices::Plane3
  include Indexable(Float64)
  getter vector
  delegate size, unsafe_fetch, coordinates, at!, to: vector

  def initialize(@vector : Vector4)
  end

  def self.from_coordinates(coordinates : Tuple4)
    new(Vector4.new(coordinates))
  end

  def normal
    Vector3.new({at!(0), at!(1), at!(2)})
  end
end
