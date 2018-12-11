class Geo::Graph::DCEL(V)
  @values : Set(V)
  @vertices : Set(Vertex(V))
  @edges : Set(Edge(V))
  @faces : Set(Face(V))

  property :values, :vertices, :edges, :faces

  def initialize(values, vertices, edges, faces)
    @values = Set.new(values)
    @vertices = Set.new(vertices)
    @edges = Set.new(edges)
    @faces = Set.new(faces)
  end

  def self.polygon(values : Array(V))
    raise ArgumentError.new("three or more vertices are required") if values.size < 3

    starting_values = {values[0], values[1]}

    DCEL.simple(starting_values).tap do |dcel|
      first_edge = dcel.edge_with_target(starting_values[1])
      leading_edge = dcel.add_to_edge(first_edge, values[2..-1])
      dcel.split_face(leading_edge, first_edge.origin)
    end
  end

  def add_to_edge(edge, values)
    values.each { |value| edge = add_vertex(edge, value) }
    edge
  end

  def edge_with_target(value)
    edges.find { |edge| edge.target.value == value }.not_nil!
  end

  def self.simple(values : Tuple(V, V))
    vertices = values.map { |value| Vertex(V).new(value) }
    edges = vertices.map { |vertex| Edge(V).new(vertex) }

    face = Face(V).new(edges.first)
    edges.each { |edge| edge.face = face }

    Edge.link_adjacent(*edges)
    Edge.link_adjacent(*edges.reverse)
    Edge.link_twins(*edges)

    DCEL(V).new(values, vertices, edges, {face})
  end

  def add_vertex(incident_edge, value)
    old_next_edge = incident_edge.next

    new_vertex = Vertex(V).new(value)
    outward_edge = Edge(V).new(incident_edge.target)
    inward_edge = Edge(V).new(new_vertex)

    Edge.link_twins(outward_edge, inward_edge)

    Edge.link_adjacent(incident_edge, outward_edge)
    Edge.link_adjacent(outward_edge, inward_edge)
    Edge.link_adjacent(inward_edge, old_next_edge)

    outward_edge.face = inward_edge.face = incident_edge.face

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
end
