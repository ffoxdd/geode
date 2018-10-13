class Geo::Mesh::Edge(V)
  @origin : Vertex(V)
  @next : Edge(V)?
  @twin : Edge(V)?

  property :origin
  property! :next, :twin

  def initialize(@origin)
    @next = nil
    @twin = nil
  end
end
