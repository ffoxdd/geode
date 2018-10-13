require "../../spec_helper"

describe Geo::Mesh::Triangles(Geo::Vector3) do
  describe ".polygon" do
    it "builds a mesh with the given values" do
      p0 = Geo::Vector3.new({1.0, 1.0, 1.0})
      p1 = Geo::Vector3.new({2.0, 2.0, 2.0})
      p2 = Geo::Vector3.new({3.0, 3.0, 3.0})

      mesh = Geo::Mesh::Triangles(Geo::Vector3).polygon([p0, p1, p2])

      mesh.values.to_set.should eq([p0, p1, p2].to_set)
      mesh.vertices.map(&.value).to_set.should eq([p0, p1, p2].to_set)

      e1 = mesh.edges[0]
      e2 = e1.next
      e3 = e2.next

      inner_edges = [e1, e2, e3]

      e3.next.should eq(e1)

      e1_ = e1.twin
      e2_ = e2.twin
      e3_ = e3.twin

      outer_edges = [e1_, e2_, e3_]

      e1_.next.should eq(e3_)
      e3_.next.should eq(e2_)
      e2_.next.should eq(e1_)

      e1.origin.should eq(e3_.origin)
      e2.origin.should eq(e1_.origin)
      e3.origin.should eq(e2_.origin)

      [e1, e3_].should contain(e1.origin.edge)
      [e2, e1_].should contain(e2.origin.edge)
      [e3, e2_].should contain(e3.origin.edge)

      inner_edges.map(&.origin).to_set.should eq(mesh.vertices.to_set)
      outer_edges.map(&.origin).to_set.should eq(mesh.vertices.to_set)

      # QUESTIONS
      # - how can you make a custom matcher (for connectivity tests)?
      # - what is the most canonical way to implement the various iterators?
    end
  end
end
