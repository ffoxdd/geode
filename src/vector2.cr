require "math"

class Vector2
    getter x
    getter y

    def initialize(@x=0.0, @y=0.0)
    end

    def self.random(radius)
      theta = Random.rand * 2 * Math::PI

      self.new(
        Math.sin(theta) * radius,
        Math.cos(theta) * radius,
      )
    end

    def ==(rhs)
      component_test(rhs) { |c0, c1| c0 == c1 }
    end

    def <(rhs)
      component_test(rhs) { |c0, c1| c0 < c1 }
    end

    def >(rhs)
      component_test(rhs) { |c0, c1| c0 > c1 }
    end

    def <=(rhs)
      component_test(rhs) { |c0, c1| c0 <= c1 }
    end

    def >=(rhs)
      component_test(rhs) { |c0, c1| c0 >= c1 }
    end

    def +(rhs)
      component_map(rhs) { |c0, c1| c0 + c1 }
    end

    def -(rhs)
      component_map(rhs) { |c0, c1| c0 - c1 }
    end

    def min(rhs)
      component_map(rhs) { |c0, c1| Math.min(c0, c1) }
    end

    def max(rhs)
      component_map(rhs) { |c0, c1| Math.max(c0, c1) }
    end

    def magnitude
      Math.hypot(@x, @y)
    end

    private def component_test(rhs)
      yield(@x, rhs.x) && yield(@y, rhs.y)
    end

    private def component_map(rhs)
      Vector2.new(yield(@x, rhs.x), yield(@y, rhs.y))
    end
end
