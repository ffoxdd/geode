require "math"
require "./vector"

class Geo::Vector2
  include Geo::Vector

  def initialize(@components = {0.0, 0.0})
  end

  def self.infinite(sign)
    new({
      Float64::INFINITY * sign,
      Float64::INFINITY * sign,
    })
  end

  def self.random(radius)
    theta = Random.rand * 2 * Math::PI

    new({
      Math.sin(theta) * radius,
      Math.cos(theta) * radius,
    })
  end
end
