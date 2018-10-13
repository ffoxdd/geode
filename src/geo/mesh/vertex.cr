class Geo::Mesh::Vertex(V)
  getter value

  def initialize(@value : V)
  end

  def ==(rhs)
    value == rhs.value
  end
end
