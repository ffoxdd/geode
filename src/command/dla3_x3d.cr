require "../**"

aggregate = DLA::Aggregate(DLA::Vector3).new

1000.times { aggregate.grow }

DLA::X3DFile.new(aggregate).save
