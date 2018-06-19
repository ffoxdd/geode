require "math"
require "./vector"

struct Vector3
  include Vector(self)

  def initialize(@x = 0.0, @y = 0.0, @z = 0.0)
  end

  getter x, y, z

  def magnitude
    Math.sqrt(@x**2 + @y**2 + @z**2)
  end

  private def component_test(rhs)
    yield(@x, rhs.x) && yield(@y, rhs.y) && yield(@z, rhs.z)
  end

  private def component_map
    Vector3.new(yield(@x), yield(@y), yield(@z))
  end

  private def component_zip_map(rhs)
    Vector3.new(yield(@x, rhs.x), yield(@y, rhs.y), yield(@z, rhs.z))
  end

  def self.infinite(sign)
    Vector3.new(
      Float64::INFINITY * sign,
      Float64::INFINITY * sign,
      Float64::INFINITY * sign,
    )
  end

  def self.random(radius)
    theta = 2 * Math::PI * Random.rand
    phi = Math.acos((2 * Random.rand) - 1)
    spherical_coordinates(theta, phi, radius)
  end

  def self.spherical_coordinates(theta, phi, radius)
    Vector3.new(
      radius * Math.cos(theta) * Math.sin(phi),
      radius * Math.sin(theta) * Math.sin(phi),
      radius * Math.cos(phi),
    )
  end
end
