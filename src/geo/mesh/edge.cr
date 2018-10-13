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
end
