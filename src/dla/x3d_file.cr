require "xml"

class DLA::X3DFile
  def initialize(@aggregate : Aggregate(Geo::Vector3))
    @filename = "./data/test.x3d"
  end

  def save
    File.write(@filename, x3d_string)
  end

  XMLNS = "http://www.w3.org/2000/svg"

  private def x3d_string
    XML.build(indent: 4) do |xml|
      doctype(xml)

      x3d(xml) do
        header(xml)

        xml.element("Scene") do
          xml.element("Group") do
            # viewpoint(xml)
            @aggregate.each { |particle| build_particle(xml, particle) }
          end
        end
      end
    end
  end

  private def build_particle(xml, particle)
    xml.element("Transform", translation: translation_string(particle)) do
      xml.element("Shape") { xml.element("Sphere") }
    end
  end

  private def translation_string(particle)
    particle.center.components.join(" ")
  end

  private def viewpoint(xml)
    xml.element(
      "Viewpoint",
      centerOfRotation: "0 -1 0",
      description: @filename,
      position: "0 -1 7"
    )
  end

  private def header(xml)
    xml.element("head") do
      xml.element("meta", name: "title", content: @filename)
    end
  end

  private def x3d(xml)
    xml.element(
      "X3D", {
        "profile" => "Immersive",
        "version" => "3.2",
        "xmlns:xsd" => XSD_XMLNS,
        "xsd:noNamespaceSchemaLocation" => X3D_XSD,
      }
    ) { yield }
  end

  XSD_XMLNS = "http://www.w3.org/2001/XMLSchema-instance"
  X3D_XSD = "http://www.web3d.org/specifications/x3d-3.2.xsd"

  private def doctype(xml)
    xml.dtd(
      "X3D",
      "ISO//Web3D//DTD X3D 3.2//EN",
      "http://www.web3d.org/specifications/x3d-3.2.dtd",
    )
  end
end
