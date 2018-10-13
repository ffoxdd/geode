class Geo::Mesh::Edge(V)
  @origin : Vertex(V)
  @after : Edge(V)?
  @twin : Edge(V)?

  property origin
  property! after, twin

  def initialize(@origin)
    @after = nil
    @twin = nil
  end
end
