require "math"
require "./vector"

class Vector2
  include Vector(self)

  def initialize(@components = {0.0, 0.0})
  end

  def self.infinite(sign)
    Vector2.new({Float64::INFINITY * sign, Float64::INFINITY * sign})
  end

  def self.random(radius)
    theta = Random.rand * 2 * Math::PI

    self.new({
      Math.sin(theta) * radius,
      Math.cos(theta) * radius,
    })
  end
end
