require "math"

class Vector2
  include Vector(self)

  def initialize(@x = 0.0, @y = 0.0)
  end

  getter x, y

  def magnitude
    Math.hypot(@x, @y)
  end

  private def component_test(rhs)
    yield(@x, rhs.x) && yield(@y, rhs.y)
  end

  private def component_map
    Vector2.new(yield(@x), yield(@y))
  end

  private def component_zip_map(rhs)
    Vector2.new(yield(@x, rhs.x), yield(@y, rhs.y))
  end

  def self.infinite(sign)
    Vector2.new(Float64::INFINITY * sign, Float64::INFINITY * sign)
  end

  def self.random(radius)
    theta = Random.rand * 2 * Math::PI

    self.new(
      Math.sin(theta) * radius,
      Math.cos(theta) * radius,
    )
  end
end
