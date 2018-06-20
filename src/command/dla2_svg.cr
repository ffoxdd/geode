require "../**"

aggregate = DLA::Aggregate(Vector2).new

1000.times { aggregate.grow }

DLA::SVGFile.new(aggregate).save
