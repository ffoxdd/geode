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
      first_edge = dcel.add_segment({values[0], values[1]})
      leading_edge = dcel.add_vertices(first_edge, values[2..-1])
      dcel.split_face(leading_edge, first_edge.origin)
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
    @faces.add(face)

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

    Edge.link_adjacent(edge, outward_edge)
    Edge.link_adjacent(outward_edge, inward_edge)
    Edge.link_adjacent(inward_edge, old_next_edge)

    outward_edge.face = inward_edge.face = edge.face

    edges << outward_edge << inward_edge
    vertices << new_vertex
    values << value

    outward_edge
  end

  def split_face(edge, vertex)
    if edge.incident_to?(vertex) || edge.next.incident_to?(vertex)
      raise "vertex cannot be adjacent to the splitting target"
    end

    target_edge = edge.face.edge_with_origin(vertex).not_nil!

    old_next_edge = edge.next
    old_previous_target_edge = target_edge.previous

    new_edge = Edge(V).new(edge.target)
    new_edge_twin = Edge(V).new(vertex)

    Edge.link_twins(new_edge, new_edge_twin)

    Edge.link_adjacent(edge, new_edge)
    Edge.link_adjacent(new_edge, target_edge)

    Edge.link_adjacent(old_previous_target_edge, new_edge_twin)
    Edge.link_adjacent(new_edge_twin, old_next_edge)

    old_face = edge.face
    new_face = Face(V).new

    new_edge.face = old_face
    new_edge_twin.each_face_edge { |e| e.face = new_face }

    old_face.edge = edge
    new_face.edge = new_edge_twin

    edges << new_edge << new_edge_twin
    faces << new_face
  end

  def dilate_edge(edge, value)
    old_next_edge = edge.next
    old_previous_edge = edge.previous
    old_face = edge.face

    new_vertex = Vertex(V).new(value)
    outward_edge = Edge(V).new(edge.target)
    inward_edge = Edge(V).new(new_vertex)
    outward_edge_twin = Edge(V).new(new_vertex)
    inward_edge_twin = Edge(V).new(edge.origin)
    new_face = Face(V).new

    Edge.link_twins(outward_edge, outward_edge_twin)
    Edge.link_twins(inward_edge, inward_edge_twin)

    Edge.link_adjacent(edge, inward_edge)
    Edge.link_adjacent(inward_edge, outward_edge)
    Edge.link_adjacent(outward_edge, edge)
    Edge.link_adjacent(old_previous_edge, outward_edge_twin)
    Edge.link_adjacent(outward_edge_twin, inward_edge_twin)
    Edge.link_adjacent(inward_edge_twin, old_next_edge)

    edge.each_face_edge { |e| e.face = new_face }
    outward_edge_twin.face = inward_edge_twin.face = old_face

    values << value
    vertices << new_vertex
    edges << outward_edge << inward_edge << outward_edge_twin << inward_edge_twin
    faces << new_face

    outward_edge
  end
end
