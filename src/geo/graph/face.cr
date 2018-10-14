class Geo::Graph::Face(V)
  @edge : Edge(V)?

  property! :edge

  def initialize
    @edge = nil
  end

  def edges
    ([] of Edge(V)).tap do |result|
      edge.each_face_edge { |edge_| result << edge_ }
    end
  end

  def edge_with_origin(vertex)
    edges.find { |edge_| edge_.origin == vertex }
  end
end
