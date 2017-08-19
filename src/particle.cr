class Particle
  getter center
  getter radius

  def initialize(@center=Vector2.new, @radius=1.0)
  end

  def ==(rhs)
    center == rhs.center && radius == rhs.radius
  end

  def aabb
    AABB.new(
      minimum_point: Vector2.new(x - radius, y - radius),
      maximum_point: Vector2.new(x + radius, y + radius)
    )
  end

  # TODO: figure out if there's a standard library delegator
  macro delegate(method_name, to=raise)
    def {{method_name}}
      {{to}}.{{method_name}}
    end
  end

  delegate x, to: center
  delegate y, to: center
end
