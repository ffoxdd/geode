class Geo::Mesh::Edge(V)
  @origin : Vertex(V)
  @next : Edge(V)?
  @previous : Edge(V)?
  @twin : Edge(V)?
  @face : Face(V)?

  property :origin
  property! :next, :previous, :twin, :face

  def initialize(@origin)
    @next = nil
    @previous = nil
    @twin = nil
    @face = nil
  end

  def target
    self.next.origin
  end

  def self.link_adjacent(previous_edge, next_edge)
    previous_edge.next = next_edge
    next_edge.previous = previous_edge
  end

  def self.link_twins(edge_0, edge_1)
    edge_0.twin = edge_1
    edge_1.twin = edge_0
  end
end
