class Particle2
  getter center
  getter radius

  def initialize(@center = Vector2.new, @radius = 1.0)
  end

  delegate x, y, to: @center

  def ==(rhs)
    center == rhs.center && radius == rhs.radius
  end

  def aabb
    AABB2.new(
      minimum_point: Vector2.new(x - radius, y - radius),
      maximum_point: Vector2.new(x + radius, y + radius)
    )
  end

  def distance(test_particle : Particle2)
    displacement_vector = @center - test_particle.center
    displacement_vector.magnitude - (@radius + test_particle.radius)
  end

  def step(distance)
    self.class.new(
      center: @center + Vector2.random(distance),
      radius: @radius,
    )
  end

  def magnitude
    @center.magnitude + @radius
  end
end
