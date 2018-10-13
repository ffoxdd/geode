class Geo::Mesh::Triangles(V)
  @values : Set(V)
  @vertices : Set(Vertex(V))
  @edges : Set(Edge(V))

  def initialize(values, vertices, edges)
    @values = Set.new(values)
    @vertices = Set.new(vertices)
    @edges = Set.new(edges)
  end

  def self.polygon(values : Array(V))
    builder = PolygonBuilder(V).new(values)
    new(**builder.components)
  end

  def values
    @values.to_a
  end

  def vertices
    @vertices.to_a
  end

  def edges
    @edges.to_a
  end

  class PolygonBuilder(V)
    def initialize(@values : Array(V))
    end

    def components
      vertices = build_vertices(@values)

      inner_edges = build_edges(vertices)
      outer_edges = build_edges(vertices)

      link_cycle(inner_edges)
      link_cycle(outer_edges.reverse)

      link_twins(inner_edges, outer_edges.rotate)

      edges = inner_edges + outer_edges

      {
        values: @values,
        vertices: vertices,
        edges: edges,
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

    private def link_cycle(edges)
      cyclic_adjacent(edges) do |edge_0, edge_1|
        edge_0.next = edge_1
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
