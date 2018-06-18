require "./vector3"

class Particle3 < Particle(Vector3)
  delegate x, y, z, to: @center
end
