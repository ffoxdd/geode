require "../spec_helper"

describe DLA do
  describe "Basic growth" do
    it "grows particles and adds them to the aggregate" do
      aggregate = DLA::Aggregate(DLA::Vector3).new

      100.times { aggregate.grow }

      aggregate.aabb.covers?(
        DLA::AABB(DLA::Vector3).new(
          minimum_point: DLA::Vector3.new({-2.0, -2.0, -2.0}),
          maximum_point: DLA::Vector3.new({2.0, 2.0, 2.0}),
        )
      ).should be_true
    end
  end
end
