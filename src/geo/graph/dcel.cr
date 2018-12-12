class Geo::Graph::DCEL(V)
  def initialize
    @values = Set(V).new
    @vertices = Set(Vertex(V)).new
    @edges = Set(Edge(V)).new
    @faces = Set(Face(V)).new
  end

  getter values, vertices, edges, faces
  delegate empty?, to: @values

  def self.polygon(values : Array(V))
    raise ArgumentError.new("three or more vertices are required") if values.size < 3

    DCEL(V).new.tap do |dcel|
      each_value = values.each

      first_edge = dcel.add_segment({each_value.next.as(V), each_value.next.as(V)})
      leading_edge = dcel.add_vertices(first_edge, each_value)
      dcel.split_face(leading_edge, first_edge)
    end
  end

  def add_segment(values : Tuple(V, V))
    vertices = values.map { |value| Vertex(V).new(value) }
    edges = vertices.map { |vertex| Edge(V).new(vertex) }
    face = Face(V).new(edges.first)
    edges.each { |edge| edge.face = face }

    Edge.link_adjacent(*edges)
    Edge.link_adjacent(*edges.reverse)
    Edge.link_twins(*edges)

    @values.concat(values)
    @vertices.concat(vertices)
    @edges.concat(edges)
    @faces << face

    edges.first
  end

  def add_vertices(edge, values)
    values.each { |value| edge = add_vertex(edge, value) }
    edge
  end

  def add_vertex(edge, value)
    old_next_edge = edge.next

    new_vertex = Vertex(V).new(value)
    outward_edge = Edge(V).new(edge.target)
    inward_edge = Edge(V).new(new_vertex)

    Edge.link_twins(outward_edge, inward_edge)
    Edge.link_adjacent(edge, outward_edge, inward_edge, old_next_edge)

    outward_edge.face = inward_edge.face = edge.face

    @edges << outward_edge << inward_edge
    @vertices << new_vertex
    @values << value

    outward_edge
  end

  def split_face(edge, target_edge)
    raise "edge cannot be adjacent to the target vertex" if edge.adjacent_to?(target_edge.origin)

    old_next_edge = edge.next
    old_previous_target_edge = target_edge.previous

    new_edge = Edge(V).new(edge.target)
    new_edge_twin = Edge(V).new(target_edge.origin)

    old_face = edge.face
    new_face = Face(V).new

    Edge.link_twins(new_edge, new_edge_twin)
    Edge.link_adjacent(edge, new_edge, target_edge)
    Edge.link_adjacent(old_previous_target_edge, new_edge_twin, old_next_edge)

    new_edge.each_face_edge { |e| e.face = new_face }
    new_edge_twin.face = old_face

    new_face.edge = new_edge
    old_face.edge = new_edge_twin

    @edges << new_edge << new_edge_twin
    @faces << new_face

    new_edge
  end

  def dilate_edge(edge, value)
    new_edge = add_vertex(edge, value)
    split_face(new_edge, edge)
  end
end
