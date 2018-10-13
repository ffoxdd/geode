class Geo::Mesh::Triangles(V)
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

  class PolygonBuilder(V)
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
        edge_0.twin = edge_1
        edge_1.twin = edge_0
      end
    end

    private def build_face(edges)
      Face(V).new.tap do |face|
        edges.each { |edge| edge.face = face }
        face.edge = edges[0]
      end
    end

    private def link_cycle(edges)
      cyclic_adjacent(edges) do |edge_0, edge_1|
        edge_0.next = edge_1
        edge_1.previous = edge_0
      end
    end

    private def cyclic_adjacent(elements)
      elements.cycle.first(elements.size + 1).each_cons(2) do |(e_0, e_1)|
        yield e_0, e_1
      end
    end

    private def zip(elements_0, elements_1)
      elements_0.each_with_index { |element_0, i| yield element_0, elements_1[i] }
    end
  end
end
