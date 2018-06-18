require "./vector3"

class Particle3 < Particle(Vector3)
  delegate x, y, z, to: @center

  # def aabb
  #   AABB2.new(
  #     minimum_point: Vector2.new(x - radius, y - radius),
  #     maximum_point: Vector2.new(x + radius, y + radius)
  #   )
  # end
end
