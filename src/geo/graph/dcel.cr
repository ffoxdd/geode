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
    builder = PolygonBuilder(V).new(values)
    new(**builder.components)
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

    new_edge.face = edge.face

    # TODO: make sure the old face has a valid edge reference
    new_face = Face(V).new
    new_edge_twin.each_face_edge { |e| e.face = new_face }

    edges << new_edge << new_edge_twin
    faces << new_face
  end

  private class PolygonBuilder(V)
    property :values

    def initialize(@values : Array(V))
    end

    def components
      vertices = build_vertices(values)

      inner_edges = build_edges(vertices)
      outer_edges = build_edges(vertices)

      link_cycle(inner_edges)
      link_cycle(outer_edges.reverse)
      link_twins(inner_edges, outer_edges.rotate)

      faces = [build_face(inner_edges), build_face(outer_edges)]
      edges = inner_edges + outer_edges

      {
        values: values,
        vertices: vertices,
        edges: edges,
        faces: faces,
      }
    end

    private def build_vertices(values)
      values.map { |value| Vertex(V).new(value) }
    end

    private def build_edges(vertices)
      vertices.map do |vertex|
        Edge(V).new(vertex).tap { |edge| vertex.edge = edge }
      end
    end

    private def link_twins(edges_0, edges_1)
      zip(edges_0, edges_1) do |edge_0, edge_1|
        Edge.link_twins(edge_0, edge_1)
      end
    end

    private def build_face(edges)
      Face(V).new.tap do |face|
        edges.each { |edge| edge.face = face }
        face.edge = edges[0]
      end
    end

    private def link_cycle(edges)
      cyclic_adjacent(edges) do |previous_edge, next_edge|
        Edge.link_adjacent(previous_edge, next_edge)
      end
    end

    private def cyclic_adjacent(elements)
      elements.cycle.first(elements.size + 1).each_cons(2) do |(e_0, e_1)|
        yield e_0, e_1
      end
    end

    private def zip(elements_0, elements_1)
      elements_0.each_with_index do |element_0, i|
        yield element_0, elements_1[i]
      end
    end
  end
end
