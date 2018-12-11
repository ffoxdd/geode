require "../../spec_helper"

describe Geo::Graph::DCEL(TestValue) do
  describe "#initialize" do
    it "returns an empty DCEL" do
      dcel = Geo::Graph::DCEL(TestValue).new

      dcel.values.empty?.should be_true
      dcel.vertices.empty?.should be_true
      dcel.edges.empty?.should be_true
      dcel.faces.empty?.should be_true
    end
  end

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
      dcel = Geo::Graph::DCEL(TestValue).new
      dcel.add_segment({TestValue.new, TestValue.new})

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

  describe "#dilate_edge" do
    it "creates a triangle inside a face" do
      dcel = Geo::Graph::DCEL(TestValue).new
      incident_edge = dcel.add_segment({TestValue.new, TestValue.new})

      new_value = TestValue.new

      edge = dcel.edges.first
      old_next_edge = edge.next
      old_previous_edge = edge.previous

      dcel.dilate_edge(edge, new_value)

      inward_edge = edge.next
      outward_edge = edge.previous

      inward_edge.next.should eq(outward_edge)
      outward_edge.next.should eq(edge)

      old_previous_edge.next.should eq(outward_edge.twin)
      outward_edge.twin.next.should eq(inward_edge.twin)
      inward_edge.twin.next.should eq(old_next_edge)

      old_next_edge.face.should_not eq(edge.face)
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
end
