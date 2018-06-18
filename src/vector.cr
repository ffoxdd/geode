module Vector(V)
  def ==(rhs)
    component_test(rhs) { |c0, c1| c0 == c1 }
  end

  def <(rhs)
    component_test(rhs) { |c0, c1| c0 < c1 }
  end

  def >(rhs)
    component_test(rhs) { |c0, c1| c0 > c1 }
  end

  def <=(rhs)
    component_test(rhs) { |c0, c1| c0 <= c1 }
  end

  def >=(rhs)
    component_test(rhs) { |c0, c1| c0 >= c1 }
  end

  def +(rhs : V)
    component_zip_map(rhs) { |c0, c1| c0 + c1 }
  end

  def -(rhs : V)
    component_zip_map(rhs) { |c0, c1| c0 - c1 }
  end

  def +(scalar)
    component_map { |c| c + scalar }
  end

  def -(scalar)
    component_map { |c| c - scalar }
  end

  def *(scalar)
    component_map { |c| c * scalar }
  end

  def /(scalar)
    component_map { |c| c / scalar }
  end

  def min(rhs)
    component_zip_map(rhs) { |c0, c1| Math.min(c0, c1) }
  end

  def max(rhs)
    component_zip_map(rhs) { |c0, c1| Math.max(c0, c1) }
  end
end
