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
    FaceEdgeIterator(V).new(self)
  end

  def each_face_edge : Nil
    each_face_edge.each { |e| yield e }
  end

  def self.link_adjacent(previous_edge, next_edge)
    previous_edge.next = next_edge
    next_edge.previous = previous_edge
  end

  def self.link_twins(edge_0, edge_1)
    edge_0.twin = edge_1
    edge_1.twin = edge_0
  end

  private class FaceEdgeIterator(V)
    include Iterator(Array(V))

    def initialize(@initial_edge : Edge(V))
      @current_edge = @initial_edge
      @stopped = false
    end

    def next
      return stop if @stopped

      @current_edge.tap do
        @stopped = (@current_edge.next == @initial_edge)
        @current_edge = @current_edge.next
      end
    end

    def rewind
      @stopped = false
      @current_edge = @initial_edge
    end
  end
end
