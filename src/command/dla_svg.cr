require "../**"

aggregate = DLA::Aggregate.new

1000.times { aggregate.grow }

DLA::SVGFile.new(aggregate).save
