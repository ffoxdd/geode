class Particle(V)
  getter center
  getter radius

  def initialize(@center = V.new, @radius = 1.0)
  end

  # delegate x, y, z, to: @center

  def ==(rhs)
    center == rhs.center && radius == rhs.radius
  end

  # def aabb
  #   AABB2.new(
  #     minimum_point: Vector2.new(x - radius, y - radius),
  #     maximum_point: Vector2.new(x + radius, y + radius)
  #   )
  # end

  def distance(test_particle : Particle(V))
    displacement_vector = @center - test_particle.center
    displacement_vector.magnitude - (@radius + test_particle.radius)
  end

  def step(distance)
    self.class.new(
      center: @center + V.random(distance),
      radius: @radius,
    )
  end

  def magnitude
    @center.magnitude + @radius
  end
end
