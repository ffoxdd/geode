require "math"
require "./vector"

struct Vector3
  include Vector(self)

  def initialize(@components = {0.0, 0.0, 0.0})
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
    Vector3.new({
      radius * Math.cos(theta) * Math.sin(phi),
      radius * Math.sin(theta) * Math.sin(phi),
      radius * Math.cos(phi),
    })
  end
end
