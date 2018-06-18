require "./vector2"

class Particle2 < Particle(Vector2)
  delegate x, y, to: @center

  def aabb
    AABB2.new(
      minimum_point: Vector2.new(x - radius, y - radius),
      maximum_point: Vector2.new(x + radius, y + radius)
    )
  end
end
