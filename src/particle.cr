class Particle(V)
  getter center
  getter radius

  def initialize(@center = V.new, @radius = 1.0)
  end

  def ==(rhs)
    center == rhs.center && radius == rhs.radius
  end

  def aabb
    AABB(V).new(
      minimum_point: center - radius,
      maximum_point: center + radius,
    )
  end

  def distance(test_particle : self)
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
