require "../**"

aggregate = DLA::Aggregate(Geo::Vector3).new

1000.times { aggregate.grow }

DLA::X3DFile.new(aggregate).save
