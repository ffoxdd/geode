class Geo::Graph::Edge(V)
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

  def incident_to?(vertex)
    origin == vertex || target == vertex
  end

  def each_face_edge
    current_edge = self

    loop do
      yield current_edge
      return if current_edge.next == self
      current_edge = current_edge.next
    end
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
