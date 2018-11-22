require "math"
require "./vector"

struct DLA::Vector3
  include Vector

  def initialize(@components = {0.0, 0.0, 0.0})
  end

  def self.infinite(sign)
    new({
      Float64::INFINITY * sign,
      Float64::INFINITY * sign,
      Float64::INFINITY * sign,
    })
  end

  def self.random(radius)
    theta = 2 * Math::PI * Random.rand
    phi = Math.acos((2 * Random.rand) - 1)
    from_spherical_coordinates(theta, phi, radius)
  end

  def self.from_spherical_coordinates(theta, phi, radius)
    new({
      radius * Math.cos(theta) * Math.sin(phi),
      radius * Math.sin(theta) * Math.sin(phi),
      radius * Math.cos(phi),
    })
  end
end
