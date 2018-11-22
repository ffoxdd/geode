module DLA::Vector
  getter components
  delegate :[], to: @components

  def ==(rhs)
    test(rhs) { |c0, c1| c0 == c1 }
  end

  def <(rhs)
    test(rhs) { |c0, c1| c0 < c1 }
  end

  def >(rhs)
    test(rhs) { |c0, c1| c0 > c1 }
  end

  def <=(rhs)
    test(rhs) { |c0, c1| c0 <= c1 }
  end

  def >=(rhs)
    test(rhs) { |c0, c1| c0 >= c1 }
  end

  def +(rhs : self)
    zip_map(rhs) { |c0, c1| c0 + c1 }
  end

  def -(rhs : self)
    zip_map(rhs) { |c0, c1| c0 - c1 }
  end

  def +(scalar)
    map { |c| c + scalar }
  end

  def -(scalar)
    map { |c| c - scalar }
  end

  def *(scalar)
    map { |c| c * scalar }
  end

  def /(scalar)
    map { |c| c / scalar }
  end

  def min(rhs)
    zip_map(rhs) { |c0, c1| Math.min(c0, c1) }
  end

  def max(rhs)
    zip_map(rhs) { |c0, c1| Math.max(c0, c1) }
  end

  def magnitude
    Math.sqrt(
      @components.map { |c| c ** 2 }.sum
    )
  end

  private def test(rhs)
    zip(rhs).all? { |c1, c2| yield(c1, c2) }
  end

  private def map()
    self.class.new(
      @components.map { |c| yield c }
    )
  end

  private def zip(rhs)
    @components.map_with_index { |c, i| {c, rhs[i]} }
  end

  private def zip_map(rhs)
    self.class.new(
      zip(rhs).map { |c1, c2| yield(c1, c2) }
    )
  end
end
