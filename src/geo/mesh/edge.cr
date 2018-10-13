class Geo::Mesh::Edge(V)
  @origin : Vertex(V)
  @next : Edge(V)?
  @twin : Edge(V)?
  @face : Face(V)?

  property :origin
  property! :next, :twin, :face

  def initialize(@origin)
    @next = nil
    @twin = nil
    @face = nil
  end
end
