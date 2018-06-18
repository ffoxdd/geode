require "./vector2"

class Particle2 < Particle(Vector2)
  delegate x, y, to: @center
end
