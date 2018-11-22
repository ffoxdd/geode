require "../**"

aggregate = DLA::Aggregate(DLA::Vector2).new

1000.times { aggregate.grow }

DLA::SVGFile.new(aggregate).save
