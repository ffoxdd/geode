require "../../spec_helper"

class TestValue
end

describe Geo::Graph::DCEL(TestValue) do
  describe ".polygon" do
    it "builds a dcel with the given values" do
      values = Array.new(3) { TestValue.new }
      dcel = Geo::Graph::DCEL(TestValue).polygon(values)

      dcel.values.should eq(values.to_set)
      dcel.vertices.map(&.value).to_set.should eq(values.to_set)

      e1 = dcel.edges.first
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

      inner_edges.map(&.origin).to_set.should eq(dcel.vertices)
      outer_edges.map(&.origin).to_set.should eq(dcel.vertices)

      f = e1.face
      f_ = e1_.face

      inner_edges.map(&.face).to_set.should eq([f].to_set)
      outer_edges.map(&.face).to_set.should eq([f_].to_set)

      [f, f_].to_set.should eq(dcel.faces)
    end
  end

  describe "#add_vertex" do
    it "adds a vertex by connecting [incident_vertex.target, new_vertex]" do
      dcel = Geo::Graph::DCEL(TestValue).simple(TestValue.new, TestValue.new)
      new_value = TestValue.new

      incident_edge = dcel.edges.first
      old_next_edge = incident_edge.next

      dcel.add_vertex(incident_edge, new_value)

      outward_edge = incident_edge.next
      inward_edge = outward_edge.next

      dcel.edges.should contain(outward_edge)
      dcel.edges.should contain(inward_edge)

      incident_edge.next.should eq(outward_edge)
      outward_edge.previous.should eq(incident_edge)

      outward_edge.next.should eq(inward_edge)
      inward_edge.previous.should eq(outward_edge)

      inward_edge.next.should eq(old_next_edge)
      old_next_edge.previous.should eq(inward_edge)

      outward_edge.twin.should eq(inward_edge)
      inward_edge.twin.should eq(outward_edge)

      inward_edge.origin.value.should eq(new_value)

      outward_edge.face.should eq(incident_edge.face)
      inward_edge.face.should eq(incident_edge.face)
    end
  end

  describe "#split_face" do
    it "splits the face along the line indicated by an edge and a vertex" do
      values = Array.new(4) { TestValue.new }
      dcel = Geo::Graph::DCEL(TestValue).polygon(values)

      edge_1 = dcel.edges.first
      edge_2 = edge_1.next
      edge_3 = edge_2.next
      edge_4 = edge_3.next

      dcel.split_face(edge_1, edge_4.origin)

      new_edge = edge_1.next

      new_edge.next.should eq(edge_4)
      edge_4.previous.should eq(new_edge)

      new_edge.origin.should eq(edge_2.origin)
      new_edge.face.should eq(edge_1.face)

      new_edge.twin.next.should eq(edge_2)
      edge_2.previous.should eq(new_edge.twin)

      edge_3.next.should eq(new_edge.twin)
      new_edge.twin.previous.should eq(edge_3)

      new_edge.face.should_not eq(new_edge.twin.face)

      edge_2.face.should eq(new_edge.twin.face)
      edge_3.face.should eq(new_edge.twin.face)
    end
  end

  describe ".simple" do
    it "returns a DCEL with two vertices" do
      value_1 = TestValue.new
      value_2 = TestValue.new

      dcel = Geo::Graph::DCEL(TestValue).simple(value_1, value_2)

      dcel.vertices.size.should eq(2)
      dcel.edges.size.should eq(2)
      dcel.faces.size.should eq(1)

      vertex_1 = dcel.vertices.to_a.first
      vertex_2 = dcel.vertices.to_a.last

      edge_1 = dcel.edges.to_a.first
      edge_2 = dcel.edges.to_a.last

      face = dcel.faces.to_a.first

      vertex_1.value.should eq(value_1)
      vertex_2.value.should eq(value_2)

      edge_1.origin.should eq(vertex_1)
      edge_2.origin.should eq(vertex_2)

      edge_1.next.should eq(edge_2)
      edge_2.next.should eq(edge_1)

      edge_1.previous.should eq(edge_2)
      edge_2.previous.should eq(edge_1)

      edge_1.twin.should eq(edge_2)
      edge_2.twin.should eq(edge_1)

      edge_1.face.should eq(face)
      edge_2.face.should eq(face)
    end
  end
end
