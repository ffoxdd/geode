class AABB
  getter minimum_point
  getter maximum_point

  def initialize(@minimum_point=Vector2.new, @maximum_point=Vector2.new)
  end

  def ==(rhs)
    minimum_point == rhs.minimum_point &&
    maximum_point == rhs.maximum_point
  end

  def covers?(point : Vector2)
    minimum_point <= point && point <= maximum_point
  end

  def covers?(aabb : AABB)
    minimum_point <= aabb.minimum_point && maximum_point >= aabb.maximum_point
  end

  def union(rhs)
    AABB.new(
      minimum_point: minimum_point.min(rhs.minimum_point),
      maximum_point: maximum_point.max(rhs.maximum_point),
    )
  end

  def size
    maximum_point - minimum_point
  end

  def center
    minimum_point + (size / 2)
  end

  def self.degenerate
    AABB.new(
      minimum_point: Vector2.infinite(1),
      maximum_point: Vector2.infinite(-1),
    )
  end
end
