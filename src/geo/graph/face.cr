class Geo::Graph::Face(V)
  @edge : Edge(V)?

  property! :edge

  def initialize(@edge = nil)
  end

  def each_edge
    edge.each_face_edge
  end

  def each_vertex
    each_edge.map(&.origin)
  end

  def each_value
    each_vertex.map(&.value)
  end

  def vertex_count
    each_edge.size
  end

  def triangle?
    vertex_count == 3
  end
end
