require "../../spec_helper"

describe Geo::Mesh::Triangles(Geo::Vector3) do
  describe ".polygon" do
    it "builds a mesh with the given values" do
      p1 = Geo::Vector3.new({1.0, 1.0, 1.0})
      p2 = Geo::Vector3.new({2.0, 2.0, 2.0})
      p3 = Geo::Vector3.new({3.0, 3.0, 3.0})

      mesh = Geo::Mesh::Triangles(Geo::Vector3).polygon([p1, p2, p3])

      mesh.values.should eq([p1, p2, p3].to_set)
      mesh.vertices.map(&.value).to_set.should eq([p1, p2, p3].to_set)

      e1 = mesh.edges.first
      e2 = e1.next
      e3 = e2.next

      e1.previous.should eq(e3)
      e2.previous.should eq(e1)
      e3.previous.should eq(e2)

      inner_edges = [e1, e2, e3]

      e3.next.should eq(e1)

      e1_ = e1.twin
      e2_ = e2.twin
      e3_ = e3.twin

      outer_edges = [e1_, e2_, e3_]

      e1_.next.should eq(e3_)
      e3_.next.should eq(e2_)
      e2_.next.should eq(e1_)

      e3_.previous.should eq(e1_)
      e2_.previous.should eq(e3_)
      e1_.previous.should eq(e2_)

      e1.origin.should eq(e3_.origin)
      e2.origin.should eq(e1_.origin)
      e3.origin.should eq(e2_.origin)

      [e1, e3_].should contain(e1.origin.edge)
      [e2, e1_].should contain(e2.origin.edge)
      [e3, e2_].should contain(e3.origin.edge)

      inner_edges.map(&.origin).to_set.should eq(mesh.vertices)
      outer_edges.map(&.origin).to_set.should eq(mesh.vertices)

      f = e1.face
      f_ = e1_.face

      inner_edges.map(&.face).to_set.should eq([f].to_set)
      outer_edges.map(&.face).to_set.should eq([f_].to_set)

      [f, f_].to_set.should eq(mesh.faces)
    end
  end

  # might be better with these primitives:
  #   add_vertex(vertex, new_value)
  #   split_face(edge, vertex)
  #
  # then we can make
  #   add_vertex_at_edge(edge, new_value)
  #     - one add_vertex and one split_face
  #
  #   subdivide_face(face, new_value)
  #     - one add_vertex and iterative split_face's
  #
  # delaunay will need quadrilateral edge flipping
end
