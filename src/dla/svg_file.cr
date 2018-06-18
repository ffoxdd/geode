require "xml"

class DLA::SVGFile
  def initialize(@aggregate : DLA::Aggregate, @scale = 10, @padding = 0.2,
    @filename = "./data/test.svg")
  end

  def save
    File.write(@filename, svg_string)
  end

  XMLNS = "http://www.w3.org/2000/svg"

  private def svg_string
    XML.build do |xml|
      xml.element("svg", xmlns: XMLNS, width: width, height: height) do
        each { |particle| build_particle(xml, particle) }
      end
    end
  end

  private def each(&block)
    @aggregate.each { |particle| yield transform(particle) }
  end

  private def build_particle(xml, particle)
    xml.element(
      "circle",
      cx: particle.x,
      cy: particle.y,
      r: particle.radius,
      fill: "black",
    )
  end

  private def transform(particle : Particle2)
    Particle2.new(
      center: particle.center * @scale + offset,
      radius: particle.radius * @scale,
    )
  end

  private def offset
    origin - (@aggregate.aabb.center * @scale)
  end

  private def origin
    Vector2.new(width, height) / 2
  end

  private def width
    viewport_size.x
  end

  private def height
    viewport_size.y
  end

  private def viewport_size
    @aggregate.aabb.size * @scale * (1 + @padding)
  end
end
