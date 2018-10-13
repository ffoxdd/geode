class Geo::Graph::Vertex(V)
  @edge : Edge(V)?

  getter :value
  property! :edge

  def initialize(@value : V)
    @edge = nil
  end

  def ==(rhs)
    value == rhs.value
  end
end
