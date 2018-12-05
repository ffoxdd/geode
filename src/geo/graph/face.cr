class Geo::Graph::Face(V)
  @edge : Edge(V)?

  property! :edge

  def initialize(@edge = nil)
  end

  def edge_with_origin(vertex)
    each_edge.find { |edge_| edge_.origin == vertex }
  end

  def each_edge
    edge.each_face_edge
  end
end
