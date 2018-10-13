class Geo::Graph::Face(V)
  @edge : Edge(V)?

  property! :edge

  def initialize
    @edge = nil
  end
end
