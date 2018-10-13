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

      e1.target.should eq(e2.origin)
      e2.target.should eq(e3.origin)
      e3.target.should eq(e1.origin)

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

      e1_.target.should eq(e3_.origin)
      e3_.target.should eq(e2_.origin)
      e2_.target.should eq(e1_.origin)

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

  describe "#add_vertex" do
    it "adds a vertex by connecting [incident_vertex.target, new_vertex]" do
      p1 = Geo::Vector3.new({1.0, 1.0, 1.0})
      p2 = Geo::Vector3.new({2.0, 2.0, 2.0})
      p3 = Geo::Vector3.new({3.0, 3.0, 3.0})

      mesh = Geo::Mesh::Triangles(Geo::Vector3).polygon([p1, p2, p3])

      p4 = Geo::Vector3.new({4.0, 4.0, 4.0})

      incident_edge = mesh.edges.first
      old_next_edge = incident_edge.next

      mesh.add_vertex(incident_edge, p4)

      outward_edge = incident_edge.next
      inward_edge = outward_edge.next

      incident_edge.next.should eq(outward_edge)
      outward_edge.previous.should eq(incident_edge)

      outward_edge.next.should eq(inward_edge)
      inward_edge.previous.should eq(outward_edge)

      inward_edge.next.should eq(old_next_edge)
      old_next_edge.previous.should eq(inward_edge)

      outward_edge.twin.should eq(inward_edge)
      inward_edge.twin.should eq(outward_edge)

      inward_edge.origin.value.should eq(p4)

      outward_edge.face.should eq(incident_edge.face)
      inward_edge.face.should eq(incident_edge.face)
    end
  end

  # might be better with these primitives:
  #   add_vertex(incident_vertex, value)
  #   split_face(edge, vertex)
  #
  # then we can make
  #   dilate_edge(edge, value)
  #     - one add_vertex and one split_face
  #
  #   subdivide_face(face, value)
  #     - one add_vertex and iterative split_face's
  #
  # delaunay will also need quadrilateral edge flipping

  # better naming is probably mesh -> graph and triangles -> dcel
end
